<template>
  <div>
    <nav>
      <router-link to="/login">登录</router-link> |
      <router-link to="/drugs">药品管理</router-link> |
      <router-link to="/reminders">用药提醒</router-link> |
      <router-link to="/health">健康信息</router-link>|
      <router-link to="/family">家庭成员管理</router-link>
      <button @click="logout">退出登录</button>
    </nav>

    <hr />

    <router-view />
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

<style>
nav {
  margin-bottom: 10px;
}
nav a {
  margin-right: 10px;
}
</style>
