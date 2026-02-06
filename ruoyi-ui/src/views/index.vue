<template>
  <div class="app-container home">
<!--    聚合搜素平台-->
    <el-container>
      <el-header>
        <el-row>
          <el-col :span="20"><div class="grid-content bg-purple">
            <el-form :model="queryParams" ref="queryForm" size="big" :inline="true" v-show="showSearch" label-width="68px">
              <el-form-item label="商品名:" prop="medicineName">
                <el-autocomplete
                  class="inline-input"
                  v-model="suggestion"
                  :fetch-suggestions="querySearchAsync"
                  placeholder="请输入您要搜索的商品名"
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
          </div></el-col>
          <el-col :span="4"><div class="grid-content bg-purple-light">
<!--            这里放着二维码-->
<!--            <div class="code" style="border: 3px solid red; width: 130px;height: 130px;">-->
<!--              <el-img :src="code_url" style="width: 130px;height: 130px"></el-img>-->
<!--            </div>-->
            <el-image
              style="align-content: center;width: 130px; height: 130px;"
              :src="code_url">
            </el-image>


          </div></el-col>
        </el-row>

      </el-header>
      <el-main>
        <br/>
        <br/>
<!--        商品信息-->
        <el-descriptions class="margin-top" title="商品信息" :column="3"  border>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-user"></i>
              上链ID
            </template>
            {{infoList.product.id}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-mobile-phone"></i>
              商品名
            </template>
            {{infoList.product.productName}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-location-outline"></i>
              商品规格
            </template>
            {{infoList.product.tp}}
          </el-descriptions-item>

          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              商品产地
            </template>
            {{infoList.product.plantCity}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              商品唯一码
            </template>
            {{infoList.product.onlyCode}}
          </el-descriptions-item>
          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              上链时间戳
            </template>
            {{infoList.product.timeStamp}}
          </el-descriptions-item>

          <el-descriptions-item>
            <template slot="label">
              <i class="el-icon-office-building"></i>
              上链Hash
            </template>
            {{infoList.product.txHash}}
          </el-descriptions-item>
        </el-descriptions>
<!--        种植端个人信息-->
<!--        grow / medicine /fertilizer -->
        <br/>
        <br/>
        <h1> <b>作物生长信息</b></h1>
        <el-table
          :data="infoList.grow"
          style="width: 100%"
          height="200" >
            <el-table-column  prop="id" label="种植信息上链ID"  width="200"> </el-table-column>
            <el-table-column  prop="plantTime" label="种植时间"  width="200">  </el-table-column>
            <el-table-column prop="reapTime"  label="成熟时间" width="200">  </el-table-column>
<!--            <el-table-column  prop="timeStamp"   label="时间戳"  width="300"> </el-table-column>-->
            <el-table-column  prop="txHash"  label="上链Hash"  width="600">  </el-table-column>
            <template slot="empty">
              <el-empty ></el-empty>
            </template>
        </el-table>
<!--        用药信息-->
        <br/>
        <br/>
        <h1> <b>用药信息</b></h1>
        <el-table
          :data="infoList.medicine"
          style="width: 100%"
          height="200" >
          <el-table-column  prop="id" label="用药信息上链ID"  width="300"> </el-table-column>
          <el-table-column  prop="name" label="用药名称"  width="100">  </el-table-column>
          <el-table-column prop="useTime"  label="使用时间" width="200">  </el-table-column>
          <el-table-column  prop="batchNo"   label="使用批次"  width="150"> </el-table-column>
          <el-table-column  prop="amount"   label="使用数量"  width="100"> </el-table-column>
<!--          <el-table-column  prop="timeStamp"   label="交易时间戳"  width="200"> </el-table-column>-->
<!--          <el-table-column  prop="txHash"  label="上链Hash"  width="600">  </el-table-column>-->
          <template slot="empty">
            <el-empty ></el-empty>
          </template>
        </el-table>
<!--        肥料信息-->
        <br/>
        <br/>
        <h1> <b>肥料/饲料信息</b></h1>
        <el-table
          :data="infoList.fertilizer"
          style="width: 100%"
          height="200" >
          <el-table-column  prop="id" label="肥料/饲料信息上链ID"  width="280"> </el-table-column>
          <el-table-column  prop="name" label="肥料/饲料名称"  width="200">  </el-table-column>
          <el-table-column  prop="company" label="肥料/饲料公司"  width="200">  </el-table-column>
          <el-table-column  prop="batchNo" label="肥料/饲料生产批号"  width="200">  </el-table-column>
          <el-table-column prop="useTime"  label="肥料/饲料使用时间" width="200">  </el-table-column>
          <!--          <el-table-column  prop="timeStamp"   label="时间戳"  width="300"> </el-table-column>-->
          <!--          <el-table-column  prop="txHash"  label="上链Hash"  width="600">  </el-table-column>-->
          <template slot="empty">
            <el-empty ></el-empty>
          </template>
        </el-table>
<!--        种植端check 信息-->
        <br/>
        <br/>
        <h1> <b>种养殖检测信息</b></h1>
        <el-table :data="infoList.check"  style="width: 100%" height="200" >
          <template slot="empty">
            <el-empty ></el-empty>
          </template>
          <el-table-column prop="id" label="检查信息上链ID"  width="290"> </el-table-column>
          <el-table-column  prop="projName"  label="检测项目"  width="200">  </el-table-column>
          <el-table-column  prop="types"  label="检测类型"  width="200">  </el-table-column>
          <el-table-column prop="result"  label="检测结果"   width="200"> </el-table-column>
<!--          <el-table-column  prop="timeStamp"  label="时间戳" width="300">  </el-table-column>-->
<!--          <el-table-column  prop="txHash"   label="上链Hash"  width="600"> </el-table-column>-->
          <el-table-column prop="uploadsUrl"  label="检测报告"  width="200">
            <template slot-scope="scope">
              <el-button  size="mini" type="text" icon="el-icon-picture-outline-round"  @click="handleImages(scope.row)"
              >点击查看检测报告</el-button>
            </template>
          </el-table-column>
        </el-table>
<!--        日常巡查信息 -->
        <br/><br/>
        <h1> <b>日常监察信息</b></h1>
        <el-table :data="infoList.routineCheck"  style="width: 100%" height="200" >
          <template slot="empty">
            <el-empty ></el-empty>
          </template>
          <el-table-column prop="id" label="检查信息上链ID"  width="300"> </el-table-column>
          <el-table-column  prop="checkName"  label="日常巡查项目"  width="200">  </el-table-column>
          <el-table-column  prop="problems"  label="检查问题"  width="200">  </el-table-column>
          <el-table-column prop="proposal"  label="整改建议"   width="200"> </el-table-column>
          <el-table-column  prop="orgMember"  label="参与人员" width="100">  </el-table-column>
<!--          <el-table-column  prop="txHash"   label="上链Hash"  width="600"> </el-table-column>-->
<!--          <el-table-column prop="timeStamp"  label="时间戳"   width="200"> </el-table-column>-->
          <el-table-column prop="uploadsUrl"  label="检测报告"  width="200">
            <template slot-scope="scope">
              <el-button  size="mini" type="text" icon="el-icon-picture-outline-round"  @click="handleImages(scope.row)"
              >点击查看检测报告</el-button>
            </template>
          </el-table-column>
        </el-table>
<!--        官方巡查信息 -->
        <br/><br/>
        <h1> <b>官方监察信息</b></h1>
        <el-table :data="infoList.officialCheck"  style="width: 100%" height="200" >
          <template slot="empty">
            <el-empty ></el-empty>
          </template>
          <el-table-column  prop="id" label="官方监察上链ID"  width="300"> </el-table-column>
          <el-table-column  prop="reportTime"  label="检测时间"  width="200">  </el-table-column>
          <el-table-column  prop="reportResult"  label="检测结果"  width="100">  </el-table-column>
<!--          <el-table-column prop="timeStamp"  label="上链时间戳"   width="200"> </el-table-column>-->
<!--          <el-table-column  prop="txHash"  label="上链Hash" width="300">  </el-table-column>-->
          <el-table-column prop="reportUploadsUrl"  label="检测报告"  width="200">
            <template slot-scope="scope">
              <el-button  size="mini" type="text" icon="el-icon-picture-outline-round"  @click="handleOfficialImages(scope.row)"
              >点击查看检测报告</el-button>
            </template>
          </el-table-column>
        </el-table>

<!--        溯源链条信息？？？-->
<!--        上链信息  -->

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


      </el-main>
    </el-container>

  </div>
</template>


<script>
import {listProduct} from  "@/api/plant/product";
import {queryAllInformationByPid,queryQTCode} from "@/api/index/index";
export default {
  name: "Index",
  data() {
    return {
      //code_url:"https://pic.imgdb.cn/item/63b0392a2bbf0e79942040fe.png",
      code_url: require("@/assets/images/web.jpg"),
      contents:"http://192.168.133.43/show?id=",
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      tables:{
        label: '种植信息',

      },
      url:null,
      is_open:false,
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
     infoList:{
       product:{id:null,plantCity:null,tp:null,productName:null,onlyCode:null,txHash:null,timeStamp:null}
     },
    };
  },
  /*created() {
    this.getProductList();
  },*/
  methods: {

    cancel() {
      this.open = false;
      this.is_open = false;
      this.reset();
    },

    //查看检测报告
    handleImages(row){
      this.url = row.uploadsUrl;
      this.is_open = true;
      this.title = "查看检测报告";
    },
    handleOfficialImages(row) {
      this.url = row.reportUploadsUrl;
      this.is_open = true;
      this.title = "查看检测报告";
    },
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
      listProduct().then( response => {
        // 【修改1】后端接口改为了分页格式，数据现在存储在 response.rows 中，而不是 response.data
        this.product = response.rows;

        this.loading = false;
        var maps = []

        // 【修改2】增加非空判断，防止 this.product 为空时报错
        if (this.product && this.product.length > 0) {
          for ( var i = 0 ; i < this.product.length ; i++){
            var p = this.product[i];
            // 【关键修改】这里必须使用 p.pid (UUID)，而不是 p.id (数据库ID)
            // 因为 handleSelect 会把这个 id 赋值给 queryParams.pid，用于后续的链上查询
            maps.push({"value": p.name, "id": p.pid});
          }
        }
        this.product = maps;
      })
    },
    /*querySearch(queryString, cb) {
      let medicines = this.product;
      let results = queryString ? medicines.filter(this.createFilter(queryString)) : medicines;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },*/
    /**
     * 修改: 服务端联想搜索方法
     * 实时将输入的 queryString 发送给后端，利用后端的 SQL LIKE 查询返回匹配项
     */
    querySearchAsync(queryString, cb) {
      // 构造查询参数
      var query = {
        pageNum: 1,
        pageSize: 10, // 限制建议数量
        name: queryString // 传入关键词，后端会进行模糊匹配
      };

      // 调用后端接口
      listProduct(query).then(response => {
        var list = response.rows;
        // 转换为 el-autocomplete 需要的格式
        var results = list.map(item => {
          return {
            value: item.name, // 下拉框显示的文字
            id: item.pid      // 关键：这里绑定 pid (UUID)，用于后续链上查询
          };
        });
        cb(results);
      });
    },
    createFilter(queryString) {
      return (medicine) => {
        return (medicine.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
      };
    },
    /*handleSelect(item) {
      this.queryParams.pid = item.id;
    },*/
    /** 选中下拉框某一项时的回调 */
    handleSelect(item) {
      this.queryParams.pid = item.id; // 将选中的 UUID 赋值给查询参数
      this.suggestion = item.value;   // 确保输入框显示名字
      // 选中后立即触发搜索
      this.handleQuery();
    },
    selectChange(item) {
      this.form.pid = item;
    },

    // 表单重置
    reset() {
      this.form = {};
      this.resetForm("form");
    },
    /** 重置按钮操作 */
    /*resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },*/
    resetQuery() {
      this.resetForm("queryForm");
      this.suggestion = null;
      this.queryParams.pid = null;
      // 清空已查询到的商品信息
      this.infoList = {
        product:{id:null,plantCity:null,tp:null,productName:null,onlyCode:null,txHash:null,timeStamp:null}
      };
      // 【新增】重置二维码图片为默认图片
      this.code_url = require("@/assets/images/web.jpg");
    },

    /***
     * ======================================这些是需要改的部分=================================================================
     */
    /** 搜索按钮操作 */
    /*handleQuery() {
      this.queryParams.pageNum = 1;
      this.loading = true;
      queryAllInformationByPid( this.queryParams.pid).then( response => {
        console.log(response.data);
        this.infoList = response.data;
        this.loading = false;
      });
      //调用了 queryQTCode(content) 方法，用于生成二维码
      // 二维码的内容是基于商品 ID 拼接而成的 URL，生成后的二维码图片地址会被赋值给 code_url，并在页面右上角展示
      let content  = this.contents + this.queryParams.pid;
      queryQTCode(content).then( response => {
        this.code_url = "http://localhost:8080" + response.url;
        console.log("xxxx",this.code_url);
      })
    },*/
    handleQuery() {
      // 增加校验：必须先选择一个商品（获取到 pid）才能查询
      if (!this.queryParams.pid) {
        this.$modal.msgWarning("请先从下拉框中选择一个商品");
        return;
      }

      this.queryParams.pageNum = 1;
      this.loading = true;

      // 1. 查询链上信息
      queryAllInformationByPid(this.queryParams.pid).then(response => {
        console.log(response.data);
        this.infoList = response.data;
        this.loading = false;

        // 2. 只有查询成功才生成二维码
        let content = this.contents + this.queryParams.pid;
        queryQTCode(content).then(res => {
          this.code_url = "http://localhost:8080" + res.url;
          console.log("二维码地址", this.code_url);
        });

      }).catch(error => {
        console.error("查询失败:", error);
        this.loading = false;
        // 清空数据，避免显示残留信息
        this.infoList = {
          product: { id: null, plantCity: null, tp: null, productName: null, onlyCode: null, txHash: null, timeStamp: null }
        };
      });
    },
  },
};
</script>

<style scoped lang="scss">
.home {
  .el-form {
    margin-top: 30px;
    margin-left: 300px;
  }
}


</style>

