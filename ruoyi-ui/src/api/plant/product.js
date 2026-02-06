import request from '@/utils/request'

//  新增
export function addProduct( data ) {
    return request({
        url:'/system/product/',
        method:'post',
        data:data
    })
}

// 修改
export function updateProduct( data ) {
    return request({
        url:'/system/product/',
        method:'put',
        data:data
    })
}

// 删除
export function delProduct( id ) {
    return request({
        url:'/system/product/' + id,
        method:'delete',
    })
}


export function listProduct(query) {
    return request({
      url: '/system/product/',
      method: 'get',
      params: query
    })
  }


//   查询单个
export function getProduct( pid ) {
    return request({
        url:'/system/product/' + pid ,
        method:'get'
    })
}

// 根据名字发起搜搜
export function getProductByName ( name ) {
    return request({
        url:'/system/product/top/' + name,
        method:'get'
    })
}
