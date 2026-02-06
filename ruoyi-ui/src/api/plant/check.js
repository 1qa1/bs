
import request from '@/utils/request'
// 新增
export function addCheck ( data ) {
    return request({
        url:'/system/check/',
        method:'post',
        data:data
    })
}
// 修改
export function updateCheck ( data ) {
    return request({
        url:'/system/check/',
        method:'put',
        data:data
    })
}

// 删除
export function delCheck( id ) {
    return request({
        url:'/system/check/' + id,
        method:'delete',
    })
}

export function queryCheckByPid( id ) {
    return request({
        url:'/system/check/top/' + id,
        method:'get',
    })
}

// 得到一个check
export function getCheck( id ) {
  return request({
    url:'/system/check/' + id,
    method:'get',
  })
}

//报告上传
export function uploadsImages(param) {
  return request({
    url:'/system/check/uploads',
    method:'post',
    data:param
  })
}
