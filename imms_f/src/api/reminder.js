import request from './request'

export function getReminders(userId) {
    return request.get('/reminder', {
        params: { userId }
    })
}
