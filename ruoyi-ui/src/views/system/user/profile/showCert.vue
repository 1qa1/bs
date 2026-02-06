<template>
  <div>
    <el-form ref="form" :model="user"  label-width="80px">
      <el-image :src="user.uploadsurl">  </el-image>
    </el-form>

  </div>

</template>

<script>

import { getUserProfile } from "@/api/system/user";

export default {
  props: {
    user: {
      type: Object
    }
  },
  data() {
    return {
      url:"https://pic.imgdb.cn/item/63b0392a2bbf0e79942040fe.png",
    };
  },
  created() {
    // this.getCertUrls();
    console.log(this.user);
  },
  methods: {
    close() {
      this.$tab.closePage();
    },

    getCertUrls() {
      getUserProfile().then(response => {
        this.url = response.user.url;
      });

    },

  }
};
</script>
<style>
  /*.el-image {*/
  /*  width: 800px;*/
  /*  height: 500px;*/
  /*  margin-left: 100px;*/
  /*}*/
</style>
