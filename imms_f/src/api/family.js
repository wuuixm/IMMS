import request from './request'

export function getFamilyMembers(userId) {
    return request.get('/family', { params: { userId } })
}

export function addFamilyMember(member) {
    return request.post('/family', member)
}

export function updateFamilyMember(id, member) {
    return request.put(`/family/${id}`, member)
}

export function deleteFamilyMember(id) {
    return request.delete(`/family/${id}`)
}
