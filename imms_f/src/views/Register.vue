<template>
  <div>
    <h2>用户注册</h2>

    <input v-model="username" placeholder="用户名" />
    <input v-model="password" type="password" placeholder="密码" />

    <button @click="doRegister">注册并返回登录</button>
    <p v-if="message">{{ message }}</p>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { register } from '../api/user'

const username = ref('')
const password = ref('')
const message = ref('')
const router = useRouter()

const doRegister = async () => {
  const res = await register(username.value, password.value)
  if (res && res.data) {
    message.value = '注册成功，请登录'
    // 注册完成后跳转到登录页
    router.push('/login')
  }
}
</script>
