<template>
    <div class="app-container">
      <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
        <el-form-item label="商品名:" prop="growName">
          <el-autocomplete
            class="inline-input"
            v-model="suggestion"
            :fetch-suggestions="querySearch"
            placeholder="请输入您要搜索的商品名"
            :trigger-on-focus="false"
            @select="handleSelect"
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
            v-hasPermi="['system:grow:add']"
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
            v-hasPermi="['system:grow:edit']"
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
            v-hasPermi="['system:grow:remove']"
          >删除</el-button>
        </el-col>
        <el-col :span="1.5">
          <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            @click="handleExport"
            v-hasPermi="['system:grow:export']"
          >导出</el-button>
        </el-col>
        <right-toolbar :showSearch.sync="showSearch"></right-toolbar>
      </el-row>

      <el-table v-loading="loading" :data="growList" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" align="center" />
        <el-table-column label="产品名" align="center" prop="params.productName" />
        <el-table-column label="种植时间" align="center" prop="plantTime" />
        <el-table-column label="收获时间" align="center" prop="reapTime" />
        <el-table-column label="追溯码" align="center" prop="txHash" />
        <el-table-column label="时间戳" align="center" prop="timeStamp" />
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
              v-hasPermi="['system:grow:edit']"
            >修改</el-button>
            <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['system:grow:remove']"
            >删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
      />

      <!-- 添加或修改添加产品对话框 -->
      <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
          <el-form-item label="产品名" prop="name">
            <el-select v-model="pdName" placeholder="请选择" @change="selectChange">
              <el-option v-for="item in product" :key="item.value"  :label="item.value" :value="item.id" >
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="种植时间" prop="plantTime">
            <el-date-picker type="date" v-model="form.plantTime"  placeholder="选择一个日期"> </el-date-picker>
          </el-form-item>
          <el-form-item label="成熟时间" prop="reapTime">
            <el-date-picker type="date" v-model="form.reapTime"  placeholder="选择一个日期"> </el-date-picker>
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
import { queryGrowByPid,addGrow,updateGrow,delGrow,getGrow } from "@/api/plant/grow";
import {listProduct} from "@/api/plant/product";
export default {
  name: "grow",
  data() {
    return {
        // 修改窗口的产品名称
        pdName:null,
        // 建议
        suggestion:null,
        /*product:{},*/
        product: [],
      // 遮罩层
      loading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
       pid:null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      },
      growList:[]
    };
  },
  created() {
   this.getProductList();
    this.handleQuery(); // 【新增】页面加载时自动查询所有数据
  },
  methods: {
    //得到数据
    /*getProductList() {
        this.loading = true;
        listProduct().then( response => {
            this.product = response.data;
            this.loading = false;
            var maps = []

            for ( var i = 0 ; i < this.product.length ; i++){
                var p = this.product[i];
                maps.push({"value":p.productName,"id":p.id});
            }
            this.product = maps;
        })
    },*/
    getProductList() {
      this.loading = true;
      // 建议传入分页参数，否则后端默认可能只返回第一页（10条）数据
      listProduct({ pageNum: 1, pageSize: 1000 }).then( response => {
        // 【修改1】后端返回的是分页对象，数据在 rows 中，而不是 data
        this.product = response.rows;
        this.loading = false;
        var maps = []

        // 增加非空判断
        if (this.product && this.product.length > 0) {
          for ( var i = 0 ; i < this.product.length ; i++){
            var p = this.product[i];
            // 【修改2】p.productName -> p.name (后端实体类字段是 name)
            // 【修改3】p.id -> p.pid (通常业务逻辑关联使用的是 UUID pid)
            maps.push({"value": p.name, "id": p.pid});
          }
        }
        this.product = maps;
      })
    },
    querySearch(queryString, cb) {
        var grows = this.product;
        var results = queryString ? grows.filter(this.createFilter(queryString)) : grows;
        // 调用 callback 返回建议列表的数据
        cb(results);
      },
      createFilter(queryString) {
        return (grow) => {
          return (grow.value.toLowerCase().indexOf(queryString.toLowerCase()) > -1);
        };
      },
      handleSelect(item) {
        this.queryParams.pid = item.id;
      },

      selectChange(item) {
        this.form.pid = item;
        // let prod = null;
        // for(let i = 0 ; i < this.product.length ; i++){
        //   prod = this.product[i];
        //   if ( prod["id"] === item ) {
        //     // this.form.name = prod["value"];
        //     this.$set(this.form,'name',prod["value"]);
        //     console.log(this.form);
        //   }
        // }
      },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {

      };
      this.resetForm("form");
    },

    /** 搜索按钮操作 */
    /*handleQuery() {
      this.loading = true;
      // 【修改】如果 queryParams.pid 为空，则传递 'all' 字符串给后端
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';

      queryGrowByPid(pidToQuery).then(response => {
        // 现有接口返回的是 AjaxResult (data)，不是 TableDataInfo (rows)
        this.growList = response.data;
        this.total = this.growList.length;
        this.loading = false;
      });
    },*/
    handleQuery() {
      this.loading = true;
      // 如果 queryParams.pid 为空，则传递 'all' 字符串给后端
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';

      queryGrowByPid(pidToQuery).then(response => {
        let rawList = response.data;

        // 1. 初始化校验状态
        this.growList = rawList.map(item => {
          if (!item.params) {
            item.params = {};
          }
          // 如果状态是已上链(1)，则标记为 loading，否则为 none
          item.params.verifyStatus = (item.status === 1) ? 'loading' : 'none';
          item.params.verifyMsg = '';
          return item;
        });

        this.total = this.growList.length;
        this.loading = false;

        // 2. 触发异步校验
        this.verifyListItems();
      });
    },
    /** 异步逐个校验列表项 (新增方法) */
    verifyListItems() {
      this.growList.forEach(item => {
        // 只校验状态为“已上链”且标记为 loading 的数据
        if (item.status === 1 && item.params.verifyStatus === 'loading') {

          // 调用后端 getGrow 接口 (对应后端的 getInfo)
          getGrow(item.id).then(res => {
            const verified = res.data.params.isVerified;
            const tampered = res.data.params.tamperedFields;
            // 获取后端返回的具体消息
            const backendMsg = res.data.params.verifyMsg;
            // 更新视图状态
            if (verified) {
              this.$set(item.params, 'verifyStatus', 'success');
              this.$set(item.params, 'verifyMsg', '数据真实有效');
            } else {
              this.$set(item.params, 'verifyStatus', 'fail');
              if (tampered && tampered.length > 0) {
                this.$set(item.params, 'verifyMsg', '篡改字段: ' + tampered.join(','));
              } else {
                //this.$set(item.params, 'verifyMsg', '链上数据不一致或网络异常');
                this.$set(item.params, 'verifyMsg', backendMsg || '链上数据不一致或网络异常');
              }
            }
          }).catch(err => {
            console.error("校验请求异常", err);
            this.$set(item.params, 'verifyStatus', 'error');
          });
        }
      });
    },


    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.suggestion = null;
      this.queryParams.pid = null;
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加种植信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getGrow(id).then(response => {
        this.form = response.data;
        this.pdName = this.form.pid;
        // this.form.name = this.form.pid;
        this.open = true;
        this.title = "修改种植信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            let pid = this.form.pid;
            updateGrow(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.queryParams.pid = pid;
              this.handleQuery();
            });
          } else {
           let pid = this.form.pid;
            addGrow(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.queryParams.pid = pid;
              this.handleQuery();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除产品编号为"' + ids + '"的数据项？').then(function() {
        return delGrow(ids);
      }).then(() => {
        this.handleQuery();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },


    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/grow/export', {
        ...this.queryParams
      }, `grow_${new Date().getTime()}.xlsx`)
    },


  }
};
</script>
