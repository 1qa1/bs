<template>
  <div class="app-container show-page">
    <!-- 1. 顶部的产品核心信息卡片 -->
    <el-card class="product-card" shadow="always">
      <div slot="header" class="clearfix">
        <span class="product-title">{{ infoList.product.productName || '商品信息' }}</span>
      </div>
      <el-descriptions :column="1" border size="small">
        <el-descriptions-item>
          <template slot="label"><i class="el-icon-price-tag"></i> 商品产地</template>
          {{ infoList.product.plantCity }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label"><i class="el-icon-box"></i> 商品规格</template>
          {{ infoList.product.tp }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label"><i class="el-icon-finished"></i> 唯一码</template>
          {{ infoList.product.onlyCode }}
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label"><i class="el-icon-link"></i> 上链Hash</template>
          <div class="hash-box">
            <el-tooltip :content="infoList.product.txHash" placement="top">
              <span class="hash-text">{{ truncateHash(infoList.product.txHash) }}</span>
            </el-tooltip>
            <i class="el-icon-document-copy copy-icon" @click="copyToClipboard(infoList.product.txHash)"></i>
          </div>
        </el-descriptions-item>
        <el-descriptions-item>
          <template slot="label"><i class="el-icon-time"></i> 上链时间</template>
          {{ infoList.product.timeStamp }}
        </el-descriptions-item>
      </el-descriptions>
    </el-card>

    <!-- 2. 溯源时间线 -->
    <div class="timeline-container">
      <el-timeline>
        <el-timeline-item
          v-for="(event, index) in timelineEvents"
          :key="index"
          :icon="event.icon"
          :type="event.type === '官方监察' ? 'danger' : 'primary'"
          :color="event.color"
          :size="'large'"
          :timestamp="event.timestamp"
          placement="top"
        >
          <el-card>
            <h4>{{ event.title }}</h4>
            <div v-for="(detail, dIndex) in event.details" :key="dIndex" class="detail-item">
              <span class="detail-label">{{ detail.label }}:</span>
              <!-- 普通文本 -->
              <span v-if="!detail.isHash && !detail.isImage" class="detail-value">{{ detail.value }}</span>
              <!-- 哈希值处理 -->
              <div v-if="detail.isHash" class="hash-box">
                <el-tooltip :content="detail.value" placement="top">
                  <span class="hash-text">{{ truncateHash(detail.value) }}</span>
                </el-tooltip>
                <i class="el-icon-document-copy copy-icon" @click="copyToClipboard(detail.value)"></i>
              </div>
              <!-- 图片链接处理 -->
              <el-button v-if="detail.isImage" size="mini" type="text" @click="handleImages(detail.value)">
                点击查看报告 <i class="el-icon-picture-outline"></i>
              </el-button>
            </div>
          </el-card>
        </el-timeline-item>
        <el-timeline-item v-if="timelineEvents.length === 0 && !loading" placement="top">
          <el-empty description="暂无更多溯源信息"></el-empty>
        </el-timeline-item>
      </el-timeline>
    </div>

    <!-- 显示图片的dialog (保持不变) -->
    <el-dialog :title="title" :visible.sync="is_open" width="90%" append-to-body>
      <el-image style="width: 100%;" :src="url" fit="contain"></el-image>
    </el-dialog>
  </div>
</template>

<script>
import { queryAllInformationByPid } from "@/api/index/index";

export default {
  name: "Show",
  data() {
    return {
      loading: true,
      url: null,
      is_open: false,
      title: "",
      queryParams: {
        pid: null,
      },
      infoList: {
        product: { id: null, plantCity: null, tp: null, productName: null, onlyCode: null, txHash: null, timeStamp: null },
        grow: [],
        medicine: [],
        fertilizer: [],
        check: [],
        routineCheck: [],
        officialCheck: []
      },
    };
  },
  computed: {
    /**
     * 【核心改造】
     * 将所有分立的信息数组聚合成一个按时间排序的事件流数组
     * 供 el-timeline 使用
     */
    timelineEvents() {
      const events = [];
      const { grow, medicine, fertilizer, check, routineCheck, officialCheck } = this.infoList;

      if (grow && grow.length > 0) {
        grow.forEach(item => events.push({
          title: '作物生长', icon: 'el-icon-sunrise-1', color: '#67C23A', timestamp: item.plantTime,
          details: [
            { label: '成熟时间', value: item.reapTime },
            { label: '上链Hash', value: item.txHash, isHash: true }
          ]
        }));
      }
      if (medicine && medicine.length > 0) {
        medicine.forEach(item => events.push({
          title: '用药记录', icon: 'el-icon-first-aid-kit', color: '#E6A23C', timestamp: item.useTime,
          details: [
            { label: '药品名称', value: item.name },
            { label: '使用批次', value: item.batchNo },
            { label: '使用数量', value: item.amount },
          ]
        }));
      }
      if (fertilizer && fertilizer.length > 0) {
        fertilizer.forEach(item => events.push({
          title: '施肥记录', icon: 'el-icon-pear', color: '#E6A23C', timestamp: item.useTime,
          details: [
            { label: '肥料名称', value: item.name },
            { label: '生产公司', value: item.company },
            { label: '生产批号', value: item.batchNo },
          ]
        }));
      }
      if (check && check.length > 0) {
        check.forEach(item => events.push({
          title: '种养殖检测', icon: 'el-icon-document-checked', color: '#409EFF', timestamp: item.timeStamp,
          details: [
            { label: '检测项目', value: item.projName },
            { label: '检测类型', value: item.types },
            { label: '检测结果', value: item.result },
            { label: '检测报告', value: item.uploadsUrl, isImage: true },
          ]
        }));
      }
      if (routineCheck && routineCheck.length > 0) {
        routineCheck.forEach(item => events.push({
          title: '日常监察', icon: 'el-icon-view', color: '#409EFF', timestamp: item.checkTime,
          details: [
            { label: '巡查项目', value: item.checkName },
            { label: '发现问题', value: item.problems },
            { label: '整改建议', value: item.proposal },
            { label: '参与人员', value: item.orgMember },
            { label: '巡查报告', value: item.uploadsUrl, isImage: true },
          ]
        }));
      }
      if (officialCheck && officialCheck.length > 0) {
        officialCheck.forEach(item => events.push({
          title: '官方监察', type: 'danger', icon: 'el-icon-warning', color: '#F56C6C', timestamp: item.reportTime,
          details: [
            { label: '检测结果', value: item.reportResult },
            { label: '检测报告', value: item.reportUploadsUrl, isImage: true },
          ]
        }));
      }

      // 按时间戳降序排序，最新的在最上面
      return events.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
    }
  },
  created() {
    this.getPageUrls();
  },
  mounted() {
    this.handleQuery();
  },
  methods: {
    getPageUrls() {
      const pid = this.$route.query.id;
      if (pid) {
        this.queryParams.pid = pid;
      } else {
        this.$modal.msgError("未检测到商品ID，无法加载数据");
      }
    },

    handleQuery() {
      if (!this.queryParams.pid) return;
      this.loading = true;
      queryAllInformationByPid(this.queryParams.pid).then(response => {
        this.infoList = response.data;
        this.loading = false;
      }).catch(() => {
        this.loading = false;
      });
    },

    /**
     * 【新增】截断长哈希值，方便显示
     */
    truncateHash(hash, start = 6, end = 4) {
      if (!hash || hash.length <= start + end) {
        return hash || 'N/A';
      }
      return `${hash.substring(0, start)}...${hash.substring(hash.length - end)}`;
    },

    /**
     * 【新增】复制文本到剪贴板
     */
    copyToClipboard(text) {
      if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
          this.$modal.msgSuccess('已复制');
        }).catch(err => {
          this.$modal.msgError('复制失败');
        });
      } else {
        // 兼容旧版浏览器
        const input = document.createElement('textarea');
        input.value = text;
        document.body.appendChild(input);
        input.select();
        document.execCommand('copy');
        document.body.removeChild(input);
        this.$modal.msgSuccess('已复制');
      }
    },

    /**
     * 【优化】统一的图片查看方法
     */
    handleImages(imageUrl) {
      if (!imageUrl) {
        this.$modal.msgWarning("无可用报告图片");
        return;
      }
      this.url = imageUrl;
      // 动态替换 localhost
      if (this.url && this.url.includes('localhost')) {
        this.url = this.url.replace("localhost", window.location.hostname);
      }
      this.is_open = true;
      this.title = "查看报告";
    },
  },
};
</script>

<style scoped lang="scss">
.show-page {
  padding: 10px;
  background-color: #f4f4f5;
}

.product-card {
  margin-bottom: 20px;
  .product-title {
    font-weight: bold;
    font-size: 18px;
  }
}

.timeline-container {
  padding: 10px;
  background-color: #fff;
  border-radius: 4px;
}

.detail-item {
  font-size: 14px;
  line-height: 1.8;
  .detail-label {
    font-weight: bold;
    color: #606266;
    margin-right: 8px;
  }
  .detail-value {
    color: #303133;
  }
}

.hash-box {
  display: flex;
  align-items: center;
  .hash-text {
    color: #409EFF;
    cursor: pointer;
  }
  .copy-icon {
    margin-left: 8px;
    cursor: pointer;
    color: #909399;
    &:hover {
      color: #409EFF;
    }
  }
}

// 优化 el-descriptions 在移动端的样式
::v-deep .el-descriptions-item__label {
  width: 100px; // 固定标签宽度
}
</style>
