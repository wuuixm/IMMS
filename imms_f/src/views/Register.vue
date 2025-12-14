<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
    <div class="card-box w-full max-w-md shadow-xl">
      <h2 class="title-section text-center mb-8">用户注册</h2>

      <div class="space-y-4 mb-6">
        <input v-model="username" placeholder="用户名" class="input-primary" />
        <input v-model="password" type="password" placeholder="密码" class="input-primary" />
        <input v-model.number="age" type="number" placeholder="年龄" class="input-primary" />
        <select v-model="gender" class="input-primary bg-white">
          <option value="">请选择性别</option>
          <option value="M">男</option>
          <option value="F">女</option>
        </select>
      </div>

      <button @click="doRegister" class="btn-primary w-full mb-4">注册</button>
      <p v-if="message" class="success-box text-center">{{ message }}</p>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { register } from '../api/user'

const username = ref('')
const password = ref('')
const age = ref(0)
const gender = ref('')
const message = ref('')
const router = useRouter()

const doRegister = async () => {
  const res = await register(username.value, password.value, age.value, gender.value)
  if (res && res.data) {
    message.value = '注册成功，请登录'
    // 注册完成后跳转到登录页
    router.push('/login')
  }
}
</script>
