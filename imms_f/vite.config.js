import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        secure: false,
      },
      // 代理外部AI服务，解决浏览器CORS（仅开发环境）
      '/spark': {
        target: 'https://spark-api-open.xf-yun.com',
        changeOrigin: true,
        secure: true,
        rewrite: (path) => path.replace(/^\/spark/, '')
      }
    }
  }
})
