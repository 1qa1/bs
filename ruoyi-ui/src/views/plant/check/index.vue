<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名:" prop="checkName">
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
          v-hasPermi="['system:check:add']"
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
          v-hasPermi="['system:check:edit']"
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
          v-hasPermi="['system:check:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:check:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="checkList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="产品名" align="center" prop="params.productName" />
      <el-table-column label="检查项目名称" align="center" prop="projName" />
      <el-table-column label="检查类型" align="center" prop="types" />
      <el-table-column label="检查结果" align="center" prop="result" />
      <el-table-column label="追溯码" align="center" prop="txHash" />
      <el-table-column label="时间戳" align="center" prop="timeStamp" />
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
            v-hasPermi="['system:check:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:check:remove']"
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
        <el-form-item label="项目名称" prop="projName">
          <el-input placeholder="请输入检查项目名称" v-model="form.projName" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="检查类型" prop="types">
          <el-input placeholder="请输入检查类型" v-model="form.types" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="检查结果" prop="result">
          <el-select v-model="form.result" placeholder="请选择检查结果" >
            <el-option v-for="item in checkResult" :key="item.key"  :label="item.key" :value="item.value" >
            </el-option>
          </el-select>
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
import {addCheck,updateCheck,delCheck,queryCheckByPid,getCheck,uploadsImages} from "@/api/plant/check";
import { queryGrowByPid } from "@/api/plant/grow";

export default {
  name: "check",
  data() {
    return {
      url:null,
      is_open:false,
      fileList: [],
      headers: { 'Content-Type': 'multipart/form-data' },
      checkResult:[{"key":"合格","value":"合格"},
        {"key":"不合格","value":"不合格"}],
      // 修改窗口的产品名称
      pdName:null,
      // 建议
      suggestion:null,
      /*product:{},*/
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
      checkList:[]
    };
  },
  created() {
    this.getProductList();
    this.handleQuery(); // 页面加载时自动查询
  },
  methods: {
    /**得到product数据 */
    /**===================================这些是不需要改的部分==========================*/
    /*getProductList() {
      this.loading = true;
      queryGrowByPid('all').then( response => {
        this.product = response.data;
        this.loading = false;
        let maps = []

        if (this.product && this.product.length > 0) {
          for ( let i = 0 ; i < this.product.length ; i++){
            let p = this.product[i];
            let displayName = (p.params && p.params.productName) ? p.params.productName : "未知产品";
            displayName += " (" + p.plantTime + ")";
            maps.push({
                "value": displayName,
                "id": p.gid,
                "pid": p.pid
            });
          }
        }
        this.product = maps;
      })
    },*/
    getProductList() {
      this.loading = true;
      queryGrowByPid('all').then( response => {
        // 假设 queryGrowByPid 返回的是 list
        let rawData = response.data;
        this.loading = false;
        let maps = []

        if (rawData && rawData.length > 0) {
          for ( let i = 0 ; i < rawData.length ; i++){
            let p = rawData[i];
            let displayName = (p.params && p.params.productName) ? p.params.productName : "未知产品";
            displayName += " (" + p.plantTime + ")";
            maps.push({
              "value": displayName,
              "id": p.gid,
              "pid": p.pid
            });
          }
        }
        this.product = maps;
      })
    },
    querySearch(queryString, cb) {
      let checks = this.product;
      let results = queryString ? checks.filter(this.createFilter(queryString)) : checks;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (check) => {
        return (check.value.toLowerCase().indexOf(queryString.toLowerCase()) > -1);
      };
    },
    handleSelect(item) {
      this.queryParams.pid = item.pid;
    },
    selectChange(item) {
      this.form.gid = item; // 绑定 GID

      const selectedObj = this.product.find(p => p.id === item);
      if (selectedObj) {
        this.form.pid = selectedObj.pid;
        this.pdName = selectedObj.value;
      }
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.is_open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {};
      this.resetForm("form");
      this.fileList = [];
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
    /** 搜索按钮操作 */
    handleQuery() {
      this.loading = true;
      // 如果 pid 为空，传递 'all'
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';
      queryCheckByPid(pidToQuery).then( response => {
        this.checkList = response.data;
        this.total = this.checkList.length;
        this.loading = false;
      })
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加检查信息";
      this.pdName = null;
      this.form.gid = null;
    },
    /** 修改按钮操作 */
    /*handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getCheck(id).then(response => {
        this.form = response.data;
        // 回显
        const match = this.product.find(p => p.id === this.form.gid);
        if (match) {
            this.pdName = match.value;
        } else {
             this.pdName = this.form.pid;
        }
        this.open = true;
        this.title = "修改检查信息";
      });
    },*/
    handleUpdate(row) {
      this.reset();
      // 优先使用行内 ID，否则使用选中数组的第一个 ID
      const id = row.id || this.ids[0];
      getCheck(id).then(response => {
        this.form = response.data;
        // 回显
        const match = this.product.find(p => p.id === this.form.gid);
        if (match) {
          this.pdName = match.value;
        } else {
          this.pdName = (this.form.params && this.form.params.productName) ? this.form.params.productName : this.form.pid;
        }
        this.open = true;
        this.title = "修改检查信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (!this.form.gid) {
             this.$modal.msgError("请选择种植批次");
             return;
          }

          if (this.form.id != null) {
            let pid = this.form.pid;
            updateCheck(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.queryParams.pid = pid;
              this.handleQuery();
            });
          } else {
            let pid = this.form.pid;
            addCheck(this.form).then(response => {
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
        return delCheck(ids);
      }).then(() => {
        this.handleQuery();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },


    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/check/export', {
        ...this.queryParams
      }, `check_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>
