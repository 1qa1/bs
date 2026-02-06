import request from '@/utils/request'

// 新增
export function addMedicine ( data ) {
    return request({
        url:'/system/medicine/',
        method:'post',
        data:data
    })
}
// 修改
export function updateMedicine ( data ) {
    return request({
        url:'/system/medicine/',
        method:'put',
        data:data
    })
}

// 删除
export function delMedicine( id ) {
    return request({
        url:'/system/medicine/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的打药信息
export function queryMedicineByPid( id ) {
    return request({
        url:'/system/medicine/top/' + id,
        method:'get',
    })
}

// 查询某一个特定的医药信息
export function getMedicine( id ) {
  return request({
    url:'/system/medicine/' + id,
    method:'get',
  })
}
