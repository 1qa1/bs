import request from '@/utils/request'
// 新增
export function addFertilizer ( data ) {
    return request({
        url:'/system/fertilizer/',
        method:'post',
        data:data
    })
}
// 修改
export function updateFertilizer ( data ) {
    return request({
        url:'/system/fertilizer/',
        method:'put',
        data:data
    })
}

// 删除
export function delFertilizer( id ) {
    return request({
        url:'/system/fertilizer/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的打药信息
export function queryFertilizerByPid( id ) {
    return request({
        url:'/system/fertilizer/top/' + id,
        method:'get',
    })
}

//查询单个信息
export function getFertilizer( id ) {
  return request({
    url:'/system/fertilizer/' + id,
    method:'get',
  })
}
