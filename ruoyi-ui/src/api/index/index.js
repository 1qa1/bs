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
