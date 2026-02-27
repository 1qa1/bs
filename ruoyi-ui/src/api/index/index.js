import request from '@/utils/request'

export function queryAllInformationByPid( id ) {
  return request ({
    url:"/system/search/" + id ,
    method:"get"
  })
}

//请求二维码

export function queryQTCode(  param ) {
  return request({
    url:'/system/search/qtcode/',
    method:'post',
    data:param,
  })
}

// 【新增】获取服务器IP
export function getServerIp() {
  return request({
    url: '/system/check/get-server-ip',
    method: 'get'
  })
}
