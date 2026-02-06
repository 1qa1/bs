import request from '@/utils/request'

// 新增
export function addGrow ( data ) {
    return request({
        url:'/system/grow/',
        method:'post',
        data:data
    })
}
// 修改
export function updateGrow ( data ) {
    return request({
        url:'/system/grow/',
        method:'put',
        data:data
    })
}

// 删除
export function delGrow( id ) {
    return request({
        url:'/system/grow/' + id,
        method:'delete',
    })
}

// 查询某一个特定商品的生长信息
export function queryGrowByPid( id ) {
    return request({
        url:'/system/grow/top/' + id,
        method:'get',
    })
}

// 查询某一个生长过程的信息
export function getGrow( id ) {
    return request({
        url:'/system/grow/' + id,
        method:'get'
    })
}


