import request from './request'

// 药品 API
export function getDrugs() {
    return request.get('/drug')
}

export function getDrugsByCategory(categoryId) {
    return request.get(`/drug/category/${categoryId}`)
}

export function addDrug(drug) {
    return request.post('/drug', drug)
}

export function updateDrugStock(drugId, stock) {
    return request.put(`/drug/${drugId}/stock`, null, {
        params: { stock }
    })
}

export function deleteDrug(drugId) {
    return request.delete(`/drug/${drugId}`)
}

// 分类 API
export function getCategories() {
    return request.get('/category')
}

export function addCategory(name) {
    return request.post('/category', null, {
        params: { name }
    })
}

export function deleteCategory(categoryId) {
    return request.delete(`/category/${categoryId}`)
}
