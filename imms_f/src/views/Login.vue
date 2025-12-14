<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
    <div class="card-box w-full max-w-md shadow-xl">
      <h2 class="title-section text-center mb-8">欢迎登录</h2>

      <div class="space-y-4 mb-6">
        <input v-model="username" placeholder="用户名" class="input-primary" />
        <input v-model="password" type="password" placeholder="密码" class="input-primary" />
      </div>

      <div class="flex gap-3 mb-6">
        <button @click="doLogin" class="btn-primary flex-1">登录</button>
        <button @click="doRegister" class="btn-secondary flex-1">注册</button>
      </div>

      <p v-if="user" class="success-box">✓ 登录成功：<span class="font-bold">{{ user.username }}</span></p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { login } from '../api/user'
import { useAuthStore } from '../stores/auth'

const username = ref('')
const password = ref('')
const user = ref(null)
const router = useRouter()
const auth = useAuthStore()

const doLogin = async () => {
  const res = await login(username.value, password.value)
  user.value = res.data
  // 登录成功后跳转到健康信息页
  if (user.value && user.value.id) {
    auth.setUser(user.value)
    router.push('/health')
  }
}

const doRegister = () => {
  router.push('/register')
}
</script>
