
import request from '@/utils/request'
// 新增
export function addRoutine ( data ) {
    return request({
        url:'system/routine/',
        method:'post',
        data:data
    })
}
// 修改
export function updateRoutine ( data ) {
    return request({
        url:'system/routine/',
        method:'put',
        data:data
    })
}

// 删除
export function delRoutine( id ) {
    return request({
        url:'system/routine/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的信息
export function queryRoutineByPid( id ) {
    return request({
        url:'system/routine/top/' + id,
        method:'get',
    })
}

// 得到一个check
export function getRoutine( id ) {
  return request({
    url:'/system/routine/' + id,
    method:'get',
  })
}

//报告上传
export function uploadsImages(param) {
  return request({
    url:'/system/routine/uploads',
    method:'post',
    data:param
  })
}
