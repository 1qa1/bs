<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名:" prop="routineName">
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
          v-hasPermi="['system:routine:add']"
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
          v-hasPermi="['system:routine:edit']"
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
          v-hasPermi="['system:routine:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:routine:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="routineList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="产品名" align="center" prop="pid" />
      <el-table-column label="检查项目名称" align="center" prop="checkName" />
      <el-table-column label="检查日期" align="center" prop="checkTime" />
      <el-table-column label="检查问题" align="center" prop="problems" />
      <el-table-column label="检查建议" align="center" prop="proposal" />
      <el-table-column label="参与人员" align="center" prop="orgMember" />
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
          <el-tag type="info" v-if="scope.row.status == 0"><i class="el-icon-loading"></i> 上链中</el-tag>
          <el-tag type="success" v-if="scope.row.status == 1"><i class="el-icon-check"></i> 已上链</el-tag>
          <el-tag type="danger" v-if="scope.row.status == 2"><i class="el-icon-close"></i> 失败</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="检测报告" align="center" prop="uploadsUrl" >
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-picture-outline-round"
            @click="handleImages(scope.row)"
          >点击查看检测报告</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:routine:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:routine:remove']"
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
    <!-- 显示图片的dialog-->
    <el-dialog :title="title" :visible.sync="is_open" width="500px" append-to-body>
      <div>
        <el-image
          style="align-content: center;width: 460px; height: 460px;"
          :src="url">
        </el-image>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="cancel()">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
    <!-- 添加或修改添加产品对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="产品名" prop="name">
          <el-select v-model="pdName" placeholder="请选择" @change="selectChange">
            <el-option v-for="item in product" :key="item.value"  :label="item.value" :value="item.id" >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="项目名称" prop="checkName">
          <el-input placeholder="请输入检查项目名称" v-model="form.checkName" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="检查日期" prop="checkTime">
          <el-date-picker type="date" v-model="form.checkTime"  placeholder="选择一个日期" value-format="yyyy-MM-dd"> </el-date-picker>
        </el-form-item>
        <el-form-item label="检查问题" prop="problems">
          <el-input type="textarea" :rows="2" placeholder="请输入检查问题" v-model="form.problems" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="建议" prop="proposal">
          <el-input type="textarea" :rows="2" placeholder="请输入建议" v-model="form.proposal" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="参与人员" prop="orgMember">
          <el-input placeholder="请输入参与人员" v-model="form.orgMember" clearable>
          </el-input>
        </el-form-item>
        <!--        报告上传-->
        <el-form-item label="报告上传" prop="uploadsUrl">
          <el-upload
            :auto-upload="false"
            class="upload-demo"
            action="#"
            :on-change="handleChange"
            :before-remove="beforeRemove"
            multiple
            :limit="3"
            :headers="headers"
            :on-exceed="handleExceed"
            :file-list="fileList">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>
          </el-upload>
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
import {listProduct} from  "@/api/plant/product";
import {addRoutine,updateRoutine,delRoutine,queryRoutineByPid,getRoutine,uploadsImages} from "@/api/check/routine";

export default {
  name: "routine",
  data() {
    return {
      url:null,
      is_open:false,
      fileList: [],
      headers: { 'Content-Type': 'multipart/form-data' },
      routineResult:[{"key":"合格","value":"合格"},
        {"key":"不合格","value":"不合格"}],
      // 修改窗口的产品名称
      pdName:null,
      // 建议
      suggestion:null,
      product:[], // 初始化为数组
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
        pageNum: 1,
        pageSize: 10
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
      },
      routineList:[],
      // 新增：轮询定时器
      refreshTimer: null
    };
  },
  created() {
    this.getProductList();
    this.handleQuery(); // 页面加载时自动查询
  },
  // 新增：组件销毁前清除定时器
  beforeDestroy() {
    if (this.refreshTimer) {
      clearTimeout(this.refreshTimer);
      this.refreshTimer = null;
    }
  },
  methods: {
    /**得到product数据 */
    getProductList() {
      this.loading = true;
      // 增加分页参数，确保能获取到数据
      listProduct({ pageNum: 1, pageSize: 1000 }).then( response => {
        this.product = response.rows; // 使用 rows
        this.loading = false;
        var maps = []

        if (this.product && this.product.length > 0) {
          for ( var i = 0 ; i < this.product.length ; i++){
            var p = this.product[i];
            // 映射：name -> value (显示), pid -> id (值)
            maps.push({"value": p.name, "id": p.pid});
          }
        }
        this.product = maps;
      })
    },
    querySearch(queryString, cb) {
      let routines = this.product;
      let results = queryString ? routines.filter(this.createFilter(queryString)) : routines;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (routine) => {
        return (routine.value.toLowerCase().indexOf(queryString.toLowerCase()) > -1);
      };
    },
    handleSelect(item) {
      this.queryParams.pid = item.id;
    },
    selectChange(item) {
      this.form.pid = item;
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.is_open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {

      };
      this.resetForm("form");
      this.fileList = [];
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.suggestion = null;
      this.queryParams.pid = null;
      // 清除定时器
      if (this.refreshTimer) {
        clearTimeout(this.refreshTimer);
        this.refreshTimer = null;
      }
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },


    /***
     * ======================================这些是需要改的部分=================================================================
     */
    handleImages(row){
      this.url = row.uploadsUrl;
      this.is_open = true;
      this.title = "查看检测报告";
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
    },
    beforeRemove(file, fileList) {
      return this.$confirm(`确定移除 ${ file.name }？`);
    },
    handleChange(file,fileList){
      this.fileList = fileList;

      //  开始上传
      this.confirmUploads();

    },
    confirmUploads(){
      let param = new FormData();
      this.fileList.forEach( (val,index) => {
        param.append("file",val.raw);
      });
      uploadsImages(param).then( response => {
        this.form.uploadsUrl = "http://localhost/dev-api/" + response.url;
      });

      this.$message({
        message:"上传报告成功",
        duration:1000
      })
    },

    /** 搜索按钮操作 (修改版支持轮询) */
    handleQuery(isSilent = false) {
      // 如果不是静默刷新，显示 loading 并清除旧定时器
      if (!isSilent) {
        this.loading = true;
        if (this.refreshTimer) {
          clearTimeout(this.refreshTimer);
          this.refreshTimer = null;
        }
      }

      // 如果 pid 为空，传递 'all'
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';
      queryRoutineByPid(pidToQuery).then( response => {
        let rawList = response.data;

        // 1. 初始化校验状态
        this.routineList = rawList.map(item => {
          if (!item.params) {
            item.params = {};
          }
          // 如果状态是已上链(1)，则标记为 loading，否则为 none
          item.params.verifyStatus = (item.status === 1) ? 'loading' : 'none';
          item.params.verifyMsg = '';
          return item;
        });

        this.total = this.routineList.length;

        // 关闭 loading
        if (!isSilent) {
          this.loading = false;
        }

        // 2. 触发异步校验
        this.verifyListItems();

        // ==================== 新增：自动轮询逻辑 ====================
        // 检查当前页是否有状态为 0 (上链中) 的数据
        const hasProcessingItem = this.routineList.some(item => item.status === 0);

        // 如果有正在处理的数据，开启轮询
        if (hasProcessingItem) {
          if (this.refreshTimer) clearTimeout(this.refreshTimer);
          this.refreshTimer = setTimeout(() => {
            this.handleQuery(true); // 静默刷新
          }, 3000);
        }
        // ==========================================================
      })
    },

    /** 异步逐个校验列表项 (新增方法) */
    verifyListItems() {
      this.routineList.forEach(item => {
        // 只校验状态为“已上链”且标记为 loading 的数据
        if (item.status === 1 && item.params.verifyStatus === 'loading') {

          // 调用后端 getRoutine 接口 (对应后端的 getInfo)
          getRoutine(item.id).then(res => {
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

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加检查信息";
      this.pdName = null;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      // 优先使用行内 ID，否则使用选中数组的第一个 ID
      const id = row.id || this.ids[0];
      getRoutine(id).then(response => {
        this.form = response.data;
        this.pdName = this.form.pid; // 这里的 pid 应该是 UUID，对应下拉框的 value
        this.open = true;
        this.title = "修改检查信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            let pid = this.form.pid;
            updateRoutine(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.queryParams.pid = pid;
              this.handleQuery();
            });
          } else {
            let pid = this.form.pid;
            addRoutine(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除数据项？').then(function() {
        return delRoutine(ids);
      }).then(() => {
        this.handleQuery();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },


    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/routine/export', {
        ...this.queryParams
      }, `routine_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>
