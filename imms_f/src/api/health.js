import request from './request'

export function getHealth(userId) {
    return request.get('/health', {
        params: { userId }
    })
}

export function addHealth(record) {
    return request.post('/health', record)
}

export function updateHealth(id, record) {
    return request.put(`/health/${id}`, record)
}

export function deleteHealth(id) {
    return request.delete(`/health/${id}`)
}
