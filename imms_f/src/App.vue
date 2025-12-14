<template>
  <div class="min-h-screen bg-gray-50">
    <!-- 导航栏 -->
    <nav class="bg-blue-600 text-white shadow-md">
      <div class="max-w-6xl mx-auto px-4 py-4 flex items-center justify-between">
        <div class="flex gap-6">
          <router-link to="/login" class="hover:bg-blue-700 px-3 py-2 rounded transition">登录</router-link>
          <router-link to="/drugs" class="hover:bg-blue-700 px-3 py-2 rounded transition">药品管理</router-link>
          <router-link to="/reminders" class="hover:bg-blue-700 px-3 py-2 rounded transition">用药提醒</router-link>
          <router-link to="/health" class="hover:bg-blue-700 px-3 py-2 rounded transition">健康信息</router-link>
          <router-link to="/family" class="hover:bg-blue-700 px-3 py-2 rounded transition">家庭成员</router-link>
        </div>
        <button @click="logout" class="bg-red-500 hover:bg-red-600 px-4 py-2 rounded transition">退出登录</button>
      </div>
    </nav>

    <!-- 页面内容 -->
    <div class="max-w-6xl mx-auto p-6">
      <router-view />
    </div>
  </div>
</template>

<script setup>
import { useAuthStore } from './stores/auth'
import { useRouter } from 'vue-router'

const auth = useAuthStore()
const router = useRouter()
const logout = () => {
  auth.logout()
  router.push('/login')
}
</script>
