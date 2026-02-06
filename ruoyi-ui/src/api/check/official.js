
import request from '@/utils/request'
// 新增
export function addOfficial ( data ) {
    return request({
        url:'/system/official/',
        method:'post',
        data:data
    })
}
// 修改
export function updateOfficial ( data ) {
    return request({
        url:'/system/official/',
        method:'put',
        data:data
    })
}

// 删除
export function delOfficial( id ) {
    return request({
        url:'/system/official/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的信息
export function queryOfficialByPid( id ) {
    return request({
        url:'/system/official/top/' + id,
        method:'get',
    })
}

// 得到一个check
export function getOfficial( id ) {
  return request({
    url:'/system/official/' + id,
    method:'get',
  })
}

//报告上传
export function uploadsImages(param) {
  return request({
    url:'/system/official/uploads',
    method:'post',
    data:param
  })
}
