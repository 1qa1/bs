import request from '@/utils/request'

// 新增
export function addTransport ( data ) {
    return request({
        url:'/system/transport/',
        method:'post',
        data:data
    })
}
// 修改
export function updateTransport ( data ) {
    return request({
        url:'/system/transport/',
        method:'put',
        data:data
    })
}

// 删除
export function delTransport( id ) {
    return request({
        url:'/system/transport/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的打药信息
export function queryTransportByPid( id ) {
    return request({
        url:'/system/transport/top/' + id,
        method:'get',
    })
}

// 查询某一个特定商品的打药信息
export function getTransport( id ) {
  return request({
    url:'/system/transport/' + id,
    method:'get',
  })
}

