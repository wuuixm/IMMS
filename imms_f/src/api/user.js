import request from './request'

export function login(username, password) {
    return request.post('/user/login', null, {
        params: { username, password }
    })
}

export function register(username, password) {
    return request.post('/user/register', null, {
        params: { username, password }
    })
}
