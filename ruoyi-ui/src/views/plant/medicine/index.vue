<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名:" prop="medicineName">
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
          v-hasPermi="['system:medicine:add']"
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
          v-hasPermi="['system:medicine:edit']"
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
          v-hasPermi="['system:medicine:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['system:medicine:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="medicineList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="产品名" align="center" prop="pid" />
      <el-table-column label="用药名称" align="center" prop="name" />
      <el-table-column label="生产批号" align="center" prop="batchNo" />
      <el-table-column label="使用时间" align="center" prop="useTime" />
      <el-table-column label="使用数量" align="center" prop="amount" />
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
            v-hasPermi="['system:medicine:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['system:medicine:remove']"
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
        <el-form-item label="用药名称" prop="medicineName">
          <el-input placeholder="请输入用药名称" v-model="form.name" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="生产批号" prop="batchNo">
          <el-input placeholder="请输入生产批号" v-model="form.batchNo" clearable>
          </el-input>
        </el-form-item>
        <el-form-item label="使用时间" prop="useTime">
          <el-date-picker type="date" v-model="form.useTime"  placeholder="选择一个日期"> </el-date-picker>
        </el-form-item>
        <el-form-item label="使用数量" prop="amount">
          <el-input placeholder="请输入使用数量" v-model="form.amount" clearable>
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
import {addMedicine,updateMedicine,delMedicine,queryMedicineByPid,getMedicine} from "@/api/plant/medicine";
import { queryGrowByPid } from "@/api/plant/grow";

export default {
  name: "medicine",
  data() {
    return {
      // 修改窗口的产品名称
      pdName:null,
      // 建议
      suggestion:null,
      product:{},
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
      medicineList:[]
    };
  },
  created() {
    this.getProductList();
    this.handleQuery(); // 页面加载时自动查询
  },
  methods: {
    /**得到product数据 */
    /**这些是不需要改的部分*/
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
      // 改为查询种植记录 (查询所有)
      queryGrowByPid('all').then( response => {
        // 后端现在返回 AjaxResult，数据在 data 中
        // 记得我们刚才修改了 SysAgriGrowController，现在它返回的 items 中
        // pid 是 UUID，params.productName 是产品名
        this.product = response.data;
        this.loading = false;
        var maps = []

        if (this.product && this.product.length > 0) {
          for ( var i = 0 ; i < this.product.length ; i++){
            var p = this.product[i];
            // 构造显示名称: 产品名 (种植时间)
            // p.params.productName 可能为空? 应该不会，后端处理了默认值
            let displayName = (p.params && p.params.productName) ? p.params.productName : "未知产品";
            displayName += " (" + p.plantTime + ")";

            // 映射：value -> 显示文本, id -> gid (种植批次ID), pid -> real pid
            maps.push({
              "value": displayName,
              "id": p.gid,
              "pid": p.pid // 保存真实的 PID 以便提交
            });
          }
        }
        this.product = maps;
      })
    },
    querySearch(queryString, cb) {
      let medicines = this.product;
      let results = queryString ? medicines.filter(this.createFilter(queryString)) : medicines;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (medicine) => {
        return (medicine.value.toLowerCase().indexOf(queryString.toLowerCase()) > -1);
      };
    },
    handleSelect(item) {
      this.queryParams.pid = item.id; // 使用 GID 进行精确批次查询
    },
    selectChange(item) {
      this.form.gid = item; // 绑定 GID

      const selectedObj = this.product.find(p => p.id === item);
      if (selectedObj) {
        this.form.pid = selectedObj.pid;
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
    /*handleQuery() {
      this.queryParams.pageNum = 1;
      this.loading = true;
      queryMedicineByPid( this.queryParams.pid).then( response => {
        this.medicineList = response.data;
        this.total = this.medicineList.length;
        this.loading = false;
      })
    },*/
    /*handleQuery() {
      this.loading = true;
      // 如果 pid 为空，传递 'all'
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';
      queryMedicineByPid(pidToQuery).then( response => {
        this.medicineList = response.data;
        this.total = this.medicineList.length;
        this.loading = false;
      })
    },*/
    handleQuery() {
      this.loading = true;
      // 如果 pid 为空，传递 'all'
      const pidToQuery = this.queryParams.pid ? this.queryParams.pid : 'all';

      queryMedicineByPid(pidToQuery).then( response => {
        let rawList = response.data;

        // 1. 初始化校验状态
        this.medicineList = rawList.map(item => {
          if (!item.params) {
            item.params = {};
          }
          // 如果状态是已上链(1)，则标记为 loading，否则为 none
          item.params.verifyStatus = (item.status === 1) ? 'loading' : 'none';
          item.params.verifyMsg = '';
          return item;
        });

        this.total = this.medicineList.length;
        this.loading = false;

        // 2. 触发异步校验
        this.verifyListItems();
      })
    },

    /** 异步逐个校验列表项 (新增方法) */
    verifyListItems() {
      this.medicineList.forEach(item => {
        // 只校验状态为“已上链”且标记为 loading 的数据
        if (item.status === 1 && item.params.verifyStatus === 'loading') {

          // 调用后端 getMedicine 接口 (对应后端的 getInfo)
          getMedicine(item.id).then(res => {
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

    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加用药信息";
      this.pdName = null;
      // 确保清空 gid
      this.form.gid = null;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      /*const id = row.id || this.ids*/
      const id = row.id || this.ids[0];
      getMedicine(id).then(response => {
        this.form = response.data;
        // 回显逻辑
        // this.form.gid 应该是有的
        // pdName 应该显示对应的 "产品名 (种植时间)"
        // 我们需要遍历 this.product 找到 id == this.form.gid 的项
        // 但 this.product 只有在下拉框打开或页面加载时才渲染。
        // 尝试匹配
        const match = this.product.find(p => p.id === this.form.gid);
        if (match) {
            this.pdName = match.value;
        } else {
            // 如果没找到（可能是分页没查到，或者数据陈旧），暂时显示 gid 或 fallback
            // 也可以显示 row.pid (产品名) 但没有时间
             this.pdName = this.form.pid; // 这里的 pid 已经是 Controller 处理过的产品名了
        }

        this.open = true;
        this.title = "修改用药信息";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          // 提交前检查，确保 gid 存在
          if (!this.form.gid) {
             this.$modal.msgError("请选择种植批次");
             return;
          }

          if (this.form.id != null) {
            let pid = this.form.pid;
            updateMedicine(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.queryParams.pid = pid; // 刷新列表用 PID
              this.handleQuery();
            });
          } else {
            let pid = this.form.pid;
            addMedicine(this.form).then(response => {
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
        return delMedicine(ids);
      }).then(() => {
        this.handleQuery();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },


    /** 导出按钮操作 */
    handleExport() {
      this.download('/system/medicine/export', {
        ...this.queryParams
      }, `medicine_${new Date().getTime()}.xlsx`)
    },
  }
};
</script>
