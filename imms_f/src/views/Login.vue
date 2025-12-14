<template>
  <div>
    <h2>用户登录</h2>

    <input v-model="username" placeholder="用户名" />
    <input v-model="password" type="password" placeholder="密码" />

    <button @click="doLogin">登录</button>
    <button @click="doRegister">未登录，去注册</button>

    <p v-if="user">登录成功：{{ user.username }}</p>
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
