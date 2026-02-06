<template>
  <div class="app-container home">
    <!--    聚合搜素平台-->
    <el-container>
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
  created() {
    this.getProductList();
    this.getPageUrls();
  },
  mounted() {
    this.handleQuery();
  },
  methods: {

    //获取url
    getPageUrls(){
      let ori_url = window.location.href;
      let pid = ori_url.split("=")[1];
      this.queryParams.pid = pid;
    },

    cancel() {
      this.open = false;
      this.is_open = false;
      this.reset();
    },

    //查看检测报告
    handleImages(row){
      this.url = row.uploadsUrl;
      this.url = this.url.replace("localhost","192.168.133.43");
      this.is_open = true;
      this.title = "查看检测报告";
    },
    handleOfficialImages(row) {
      this.url = row.reportUploadsUrl;
      this.url = this.url.replace("localhost","192.168.133.43");
      console.log(this.url);
      this.is_open = true;
      this.title = "查看检测报告";
    },
    /**得到product数据 */
    /**这些是不需要改的部分*/
    getProductList() {
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
    },
    querySearch(queryString, cb) {
      let medicines = this.product;
      let results = queryString ? medicines.filter(this.createFilter(queryString)) : medicines;
      // 调用 callback 返回建议列表的数据
      cb(results);
    },
    createFilter(queryString) {
      return (medicine) => {
        return (medicine.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
      };
    },
    handleSelect(item) {
      this.queryParams.pid = item.id;
    },
    selectChange(item) {
      this.form.pid = item;
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
      this.handleQuery();
    },

    /***
     * ======================================这些是需要改的部分=================================================================
     */
    /** 搜索按钮操作 */
    handleQuery(  ) {
      this.queryParams.pageNum = 1;
      this.loading = true;
      queryAllInformationByPid( this.queryParams.pid ).then( response => {
        console.log(response.data);
        this.infoList = response.data;
        this.loading = false;
      });

      let content  = this.contents + this.queryParams.pid;
      queryQTCode(content).then( response => {
        this.code_url = "http://localhost:8080" + response.url;
        //this.code_url = "http://192.168.133.43:8080" + response.url;
      })
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

