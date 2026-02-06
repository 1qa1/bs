import request from '@/utils/request'

// 新增
export function addSell ( data ) {
    return request({
        url:'system/sell/',
        method:'post',
        data:data
    })
}
// 修改
export function updateSell ( data ) {
    return request({
        url:'system/sell/',
        method:'put',
        data:data
    })
}

// 删除
export function delSell( id ) {
    return request({
        url:'system/sell/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的打药信息
export function querySellByPid( id ) {
    return request({
        url:'system/sell/top/' + id,
        method:'get',
    })
}

// 得到一个check
export function getSell( id ) {
  return request({
    url:'/system/sell/' + id,
    method:'get',
  })
}
