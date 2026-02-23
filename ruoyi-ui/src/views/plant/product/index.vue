<template>
  <div class="app-container">
    <!-- 搜索表单 -->
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <!-- 修改1: prop 改为 name -->
<!--      <el-form-item label="商品名:" prop="name">
        &lt;!&ndash; 修改2: v-model 改为 queryParams.name &ndash;&gt;
        <el-input
          v-model="queryParams.name"
          placeholder="请输入商品名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>-->
      <!-- 使用 el-autocomplete -->
      <el-form-item label="商品名:" prop="name">
        <el-autocomplete
          class="inline-input"
          v-model="queryParams.name"
          :fetch-suggestions="querySearchAsync"
          placeholder="请输入商品名"
          :trigger-on-focus="false"
          @select="handleSelect"
          @keyup.enter.native="handleQuery"
          clearable
        ></el-autocomplete>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['system:product:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['system:product:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['system:product:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:product:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <!-- 数据表格 -->
    <el-table v-loading="loading" :data="productList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />

      <!-- 修改3: prop="productName" 改为 prop="name" (对应后端字段) -->
      <el-table-column label="产品名" align="center" prop="name" />

      <el-table-column label="种植数量" align="center" prop="number" />
      <el-table-column label="规格" align="center" prop="tp" />
      <el-table-column label="种植地" align="center" prop="plantCity" />

      <el-table-column label="商品唯一码" align="center" prop="onlyCode" />

      <el-table-column label="追溯码" align="center" prop="txHash" />
      <el-table-column label="时间戳" align="center" prop="timeStamp" />
      <!-- ================= 新增：区块链实时校验列 ================= -->
      <el-table-column label="链上核验" align="center" width="120">
        <template slot-scope="scope">
          <!-- 1. 校验中 -->
          <div v-if="scope.row.params.verifyStatus === 'loading'" style="color: #909399">
            <i class="el-icon-loading"></i> 核验中...
          </div>

          <!-- 2. 校验通过 -->
          <el-tooltip v-else-if="scope.row.params.verifyStatus === 'success'"
                      content="区块链指纹比对通过，数据未被篡改" placement="top">
            <el-tag type="success" effect="dark" size="small">
              <i class="el-icon-circle-check"></i> 真实
            </el-tag>
          </el-tooltip>

          <!-- 3. 校验失败/篡改 -->
          <el-tooltip v-else-if="scope.row.params.verifyStatus === 'fail'"
                      :content="'警告：' + scope.row.params.verifyMsg" placement="top">
            <el-tag type="danger" effect="dark" size="small">
              <i class="el-icon-warning"></i> 异常
            </el-tag>
          </el-tooltip>

          <!-- 4. 未上链 -->
          <el-tag v-else type="info" size="small">未上链</el-tag>
        </template>
      </el-table-column>
      <!-- ======================================================== -->

      <el-table-column label="上链状态" align="center" prop="status">
        <template slot-scope="scope">
          <!-- 0: 处理中 -->
          <el-tag type="info" v-if="scope.row.status == 0">
            <i class="el-icon-loading"></i> 上链中
          </el-tag>
          <!-- 1: 成功 -->
          <el-tag type="success" v-if="scope.row.status == 1">
            <i class="el-icon-check"></i> 已上链
          </el-tag>
          <!-- 2: 失败 -->
          <el-tag type="danger" v-if="scope.row.status == 2">
            <i class="el-icon-close"></i> 失败
          </el-tag>
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:product:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:product:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <!-- 修改5: 这里的 prop 和 v-model 也要改为 name -->
        <el-form-item label="产品名" prop="name">
          <el-input v-model="form.name" placeholder="请输入产品名" @blur="handleBlur" />
        </el-form-item>

        <!-- 这些字段在新增时会传给后端，但如果后端 AgriProduct 没这些字段，可能存不进去 -->
        <el-form-item label="种植数量" prop="number">
          <el-input v-model="form.number" placeholder="请输入种植数量" />
        </el-form-item>
        <el-form-item label="规格" prop="tp">
          <el-input v-model="form.tp" placeholder="请输入规格" />
        </el-form-item>
        <el-form-item label="种植地" prop="plantCity">
          <el-input v-model="form.plantCity" placeholder="请输入种植地" />
        </el-form-item>
        <el-form-item label="唯一码" prop="onlyCode">
          <el-input v-model="form.onlyCode" placeholder="请输入唯一码" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listProduct, addProduct, delProduct, updateProduct, getProduct } from "@/api/plant/product";

export default {
  name: "product",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      title: "",
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null, // 修改: productName -> name
        // number, tp, plantCity 暂时后端不支持查询，先保留或删除均可
      },
      // 表单参数
      form: {},
      rules: {},
      productList: [],
      // 新增：轮询定时器
      refreshTimer: null,
    };
  },
  created() {
    this.getList();
  },
  // 新增销毁钩子
  beforeDestroy() {
    if (this.refreshTimer) {
      clearTimeout(this.refreshTimer);
      this.refreshTimer = null;
    }
  },
  methods: {
    /** 查询列表 */
    /*getList() {
      this.loading = true;
      // 直接调用通用查询接口，它支持分页和 name 搜索
      listProduct(this.queryParams).then(response => {
        this.productList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },*/
    /*getList() {
      this.loading = true;
      listProduct(this.queryParams).then(response => {
        let rawList = response.rows;

        // 1. 初始化校验状态
        this.productList = rawList.map(item => {
          if (!item.params) {
            item.params = {};
          }
          // 如果状态是已上链(1)，则标记为 loading，否则为 none
          item.params.verifyStatus = (item.status === 1) ? 'loading' : 'none';
          item.params.verifyMsg = '';
          return item;
        });

        this.total = response.total;
        this.loading = false;

        // 2. 触发异步校验
        this.verifyListItems();
      });
    },*/
    /** 查询列表 */
    getList(isSilent = false) {
      // 如果不是静默刷新（即用户手动搜索或首次加载），则显示 loading
      if (!isSilent) {
        this.loading = true;
      }

      listProduct(this.queryParams).then(response => {
        let rawList = response.rows;

        // 1. 初始化校验状态
        this.productList = rawList.map(item => {
          if (!item.params) {
            item.params = {};
          }
          // 如果状态是已上链(1)，则标记为 loading，否则为 none
          item.params.verifyStatus = (item.status === 1) ? 'loading' : 'none';
          item.params.verifyMsg = '';
          return item;
        });

        this.total = response.total;

        // 关闭 loading
        if (!isSilent) {
          this.loading = false;
        }

        // 2. 触发异步校验
        this.verifyListItems();

        // ==================== 新增：自动轮询逻辑 ====================
        // 检查当前页是否有状态为 0 (上链中) 的数据
        const hasProcessingItem = this.productList.some(item => item.status === 0);

        // 如果有正在处理的数据，且当前没有定时器在运行，则开启轮询
        if (hasProcessingItem) {
          // 先清除可能存在的旧定时器
          if (this.refreshTimer) clearTimeout(this.refreshTimer);

          // 设置 3秒 后再次查询 (静默模式)
          this.refreshTimer = setTimeout(() => {
            this.getList(true);
          }, 3000);
        }
        // ==========================================================
      });
    },
    /** 异步逐个校验列表项 (新增方法) */
    verifyListItems() {
      this.productList.forEach(item => {
        // 只校验状态为“已上链”且标记为 loading 的数据
        if (item.status === 1 && item.params.verifyStatus === 'loading') {

          // 调用后端 getProduct 接口 (对应后端的 getInfo)
          getProduct(item.id).then(res => {
            const verified = res.data.params.isVerified;
            const tampered = res.data.params.tamperedFields;

            // 更新视图状态
            if (verified) {
              this.$set(item.params, 'verifyStatus', 'success');
              this.$set(item.params, 'verifyMsg', '数据真实有效');
            } else {
              this.$set(item.params, 'verifyStatus', 'fail');
              if (tampered && tampered.length > 0) {
                this.$set(item.params, 'verifyMsg', '篡改字段: ' + tampered.join(','));
              } else {
                this.$set(item.params, 'verifyMsg', '链上数据不一致或网络异常');
              }
            }
          }).catch(err => {
            console.error("校验请求异常", err);
            this.$set(item.params, 'verifyStatus', 'error');
          });
        }
      });
    },

    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: null,
        name: null, // 修改
        number: null,
        tp: null,
        plantCity: null,
        onlyCode: null // 修改
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList(); // 修改: 直接调用 getList，不需要单独写 getProductByName
    },
    /**
     * 联想搜索方法
     * queryString: 用户输入的关键词
     * cb: 回调函数，用于返回联想结果给组件
     */
    querySearchAsync(queryString, cb) {
      // 构造查询参数，只查少量数据用于联想，避免数据量过大
      var query = {
        pageNum: 1,
        pageSize: 10, // 限制显示10条建议
        name: queryString // 传入当前输入的关键词
      };
      // 调用后端接口
      listProduct(query).then(response => {
        var list = response.rows;
        // el-autocomplete 组件要求结果数组中必须包含 "value" 字段
        // 我们把 name 赋值给 value
        var results = list.map(item => {
          return {
            value: item.name, // 关键：必须有 value 属性，显示在下拉框中
            id: item.id       // 可以携带其他数据
          };
        });
        cb(results);
      });
    },
    /** 选中下拉框某一项时的回调 */
    handleSelect(item) {
      this.queryParams.name = item.value;
      // 选中后立即触发搜索
      this.handleQuery();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加种植产品信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getProduct(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改产品信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          //if(!this.form.productName) this.form.productName = this.form.name;
          //if(!this.form.ID) this.form.ID = this.form.pid;

          if (this.form.id != null) {
            updateProduct(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addProduct(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除产品编号为"' + ids + '"的数据项？').then(function() {
        return delProduct(ids); // 注意：这里 delProduct 需要支持数组或单个ID
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/product/export', {
        ...this.queryParams
      }, `product_${new Date().getTime()}.xlsx`)
    },
    handleBlur() {
      // 自动生成唯一码
      if (!this.form.onlyCode) { // 只有当 onlyCode 为空时才生成
        this.form.onlyCode = this.generateOnlyCode(8, 2);
      }
    },
    // 生成唯一码
    generateOnlyCode(len, radix) {
      var chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('');
      var uuid = [], i;
      radix = radix || chars.length;
      if (len) {
        for (i = 0; i < len; i++) uuid[i] = chars[0 | Math.random() * radix];
      } else {
        var r;
        uuid[8] = uuid[13] = uuid[18] = uuid[23] = '-';
        uuid[14] = '4';
        for (i = 0; i < 36; i++) {
          if (!uuid[i]) {
            r = 0 | Math.random() * 16;
            uuid[i] = chars[(i == 19) ? (r & 0x3) | 0x8 : r];
          }
        }
      }
      return uuid.join('')
    },
  }
};
</script>
