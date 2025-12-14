import request from './request'

export function getReminders(userId) {
    return request.get('/reminder', {
        params: { userId }
    })
}

export function addReminder(reminder) {
    return request.post('/reminder', reminder)
}

export function updateReminder(id, reminder) {
    return request.put(`/reminder/${id}`, reminder)
}

export function updateReminderStatus(id, status) {
    return request.put(`/reminder/${id}/status`, null, {
        params: { status }
    })
}

export function deleteReminder(id) {
    return request.delete(`/reminder/${id}`)
}
