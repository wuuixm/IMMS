import axios from 'axios'

const request = axios.create({
    // 使用相对路径配合 Vite 代理，避免跨域问题
    baseURL: '/api',
    timeout: 5000
})

export default request
