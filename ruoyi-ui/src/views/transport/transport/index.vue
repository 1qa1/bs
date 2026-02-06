<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名:" prop="transportName">
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
          v-hasPermi="['system:transport:add']"
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
          v-hasPermi="['system:transport:edit']"
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
          v-hasPermi="['system:transport:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:transport:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="transportList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="产品名" align="center" prop="pid" />
      <el-table-column label="司机姓名" align="center" prop="driverName" />
      <el-table-column label="电话号码" align="center" prop="phone" />
      <el-table-column label="车牌号" align="center" prop="carNumber" />
      <el-table-column label="商品数量" align="center" prop="productAmount" />
      <el-table-column label="出发地" align="center" prop="startCity" />
      <el-table-column label="商品规格" align="center" prop="tp" />
      <el-table-column label="终止地" align="center" prop="endCity" />
      <el-table-column label="开始时间" align="center" prop="startTime" />
      <el-table-column label="追溯码" align="center" prop="txHash" />
      <el-table-column label="时间戳" align="center" prop="timeStamp" />
      <el-table-column label="上链状态" align="center" prop="status">
        <template slot-scope="scope">
          <el-tag type="info" v-if="scope.row.status == 0"><i class="el-icon-loading"></i> 上链中</el-tag>
          <el-tag type="success" v-if="scope.row.status == 1"><i class="el-icon-check"></i> 已上链</el-tag>
          <el-tag type="danger" v-if="scope.row.status == 2"><i class="el-icon-close"></i> 失败</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['system:transport:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:transport:remove']"
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
        <el-form-item label="司机名称" prop="driverName">
          <el-input placeholder="请输入司机名称" v-model="form.driverName" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="电话号码" prop="phone">
          <el-input placeholder="请输入司机电话号码" v-model="form.phone" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="车牌号" prop="carNumber">
          <el-input placeholder="请输入车牌号" v-model="form.carNumber" clearable>
          </el-input>
        </el-form-item>
<!--        <el-form-item label="出发地" prop="startCity">
          <el-input placeholder="请输入出发地" v-model="form.startCity" clearable>
          </el-input>
        </el-form-item>-->
        <el-form-item label="出发地" prop="startCity">
          <el-input placeholder="自动获取种植地" v-model="form.startCity" disabled>
          </el-input>
        </el-form-item>
        <el-form-item label="终点地" prop="endCity">
          <el-input placeholder="请输入终点地" v-model="form.endCity" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <el-date-picker type="date" v-model="form.startTime"  placeholder="选择一个日期" value-format="yyyy-MM-dd"> </el-date-picker>
        </el-form-item>
        <el-form-item label="商品数量" prop="productAmount">
          <el-input placeholder="请输入商品数量" v-model="form.productAmount" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="商品规格" prop="tp">
          <el-input placeholder="请输入商品规格" v-model="form.tp" clearable>
          </el-input>
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
import {addTransport,updateTransport,delTransport,queryTransportByPid,getTransport} from "@/api/transport/transport";
import { queryCheckByPid } from "@/api/plant/check";

export default {
  name: "transport",
  data() {
    return {
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
      transportList:[]
    };
  },
  created() {
    this.getProductList();
    this.handleQuery(); // 页面加载时自动查询
  },
  methods: {
    /**得到product数据 */
    getProductList() {
      this.loading = true;
      // 1. 获取所有检测记录
      queryCheckByPid('all').then(checkRes => {
          let checks = checkRes.data || [];
          let qualifiedPids = new Set();
          
          // 2. 筛选出合格的产品PID
          if (checks && checks.length > 0) {
              checks.forEach(c => {
                  // 注意：后端字段可能为 Result 或 result，根据前端 Check 页面的 prop="result" 推断为小写
                  // 另外，后端 AgriBCCheck 中定义的字段名为 Result (大写)，Jackson 可能会序列化为 result (小写)
                  // 为了保险，做兼容判断
                  let res = c.result || c.Result;
                  // 根据用户需求：只能选择经过检测合格的产品
                  if (res && res.indexOf('合格') > -1) {
                      qualifiedPids.add(c.pid); // 这里的 pid 现在是 UUID (由 SysAgriCheckController 修复)
                  }
              });
          }

          // 3. 获取所有产品并过滤
          listProduct({ pageNum: 1, pageSize: 1000 }).then( response => {
            let allProducts = response.rows; // 使用 rows
            let maps = []
    
            if (allProducts && allProducts.length > 0) {
              for ( var i = 0 ; i < allProducts.length ; i++){
                var p = allProducts[i];
                
                // 核心过滤逻辑：只有在合格集合中的 PID 才显示
                if (qualifiedPids.has(p.pid)) {
                    maps.push({"value": p.name, "id": p.pid, "plantCity": p.plantCity});
                }
              }
            }
            this.product = maps;
            this.loading = false;
          })
      })
    },
    querySearch(queryString, cb) {
      let transports = this.product;
      let results = queryString ? transports.filter(this.createFilter(queryString)) : transports;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (transport) => {
        return (transport.value.toLowerCase().indexOf(queryString.toLowerCase()) > -1);
      };
    },
    handleSelect(item) {
      this.queryParams.pid = item.id;
    },
    selectChange(item) {
      this.form.pid = item;
      // 查找当前选中的产品对象
      const selectedProduct = this.product.find(p => p.id === item);
      // 如果找到了产品且有种植地信息，自动赋值给出发地
      if (selectedProduct && selectedProduct.plantCity) {
        this.form.startCity = selectedProduct.plantCity;
      }
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

    /** 搜索按钮操作 */
    handleQuery() {
      this.loading = true;
      // 如果 pid 为空，传递 'all'
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';
      queryTransportByPid(pidToQuery).then( response => {
        this.transportList = response.data;
        this.total = this.transportList.length;
        this.loading = false;
      })
    },

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加运输信息";
      this.pdName = null;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      // 优先使用行内 ID，否则使用选中数组的第一个 ID
      const id = row.id || this.ids[0];
      getTransport(id).then(response => {
        this.form = response.data;
        this.pdName = this.form.pid; // 这里的 pid 应该是 UUID，对应下拉框的 value
        this.open = true;
        this.title = "修改运输信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            let pid = this.form.pid;
            updateTransport(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.queryParams.pid = pid;
              this.handleQuery();
            });
          } else {
            let pid = this.form.pid;
            addTransport(this.form).then(response => {
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
        return delTransport(ids);
      }).then(() => {
        this.handleQuery();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },

    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/transport/export', {
        ...this.queryParams
      }, `transport_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>
