<template>
  <div>
    <h2 class="title-main">健康信息</h2>

    <!-- 选择查看对象 -->
    <div class="card-box mb-8">
      <label class="block text-gray-700 font-semibold mb-3">查看对象</label>
      <select v-model.number="targetUserId" @change="reloadHealth" class="input-primary bg-white">
        <option :value="auth.userId">本人</option>
        <option v-for="m in members" :key="m.id" :value="m.memberUserId">{{ getMemberUsername(m.memberUserId) }}（成员）</option>
      </select>
    </div>

    <!-- 用户信息 -->
    <div class="info-box mb-8">
      <h3 class="title-section mb-4">当前用户信息</h3>
      <div class="grid grid-cols-3 gap-6">
        <div class="text-center">
          <p class="text-gray-600 mb-1">用户名</p>
          <p class="text-2xl font-bold text-blue-600">{{ currentUserInfo.username || '未知' }}</p>
        </div>
        <div class="text-center">
          <p class="text-gray-600 mb-1">年龄</p>
          <p class="text-2xl font-bold text-blue-600">{{ currentUserInfo.age || '-' }}</p>
        </div>
        <div class="text-center">
          <p class="text-gray-600 mb-1">性别</p>
          <p class="text-2xl font-bold text-blue-600">{{ currentUserInfo.gender || '-' }}</p>
        </div>
      </div>
    </div>

    <!-- 新增记录 -->
    <div class="card-box mb-8">
      <h3 class="title-section">新增健康记录</h3>
      <div class="grid grid-cols-4 gap-3">
        <select v-model="form.type" class="input-primary bg-white">
          <option value="">选择类型</option>
          <option value="血压">血压</option>
          <option value="血糖">血糖</option>
          <option value="体温">体温</option>
        </select>
        <input v-model="form.value" placeholder="如 120/80" class="input-primary" />
        <input v-model="form.recordDate" type="date" class="input-primary" />
        <button @click="addRecord" class="btn-primary">新增</button>
      </div>
    </div>

    <!-- 记录列表 -->
    <div class="card-box">
      <table class="table-primary">
        <thead>
          <tr>
            <th>类型</th>
            <th>值</th>
            <th>日期</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="h in list" :key="h.id">
            <td class="font-medium">{{ h.type }}</td>
            <td class="font-mono">{{ h.value }}</td>
            <td>{{ h.recordDate }}</td>
            <td class="space-x-2">
              <button @click="startEdit(h)" class="text-blue-600 hover:text-blue-800 font-semibold">编辑</button>
              <button @click="removeRecord(h.id)" class="btn-danger">删除</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 编辑 -->
      <div v-if="editing" class="mt-8 p-6 bg-yellow-50 border-l-4 border-yellow-500 rounded-lg">
        <h3 class="title-section mb-4">编辑记录</h3>
        <div class="grid grid-cols-4 gap-3 mb-4">
          <select v-model="editForm.type" class="input-primary bg-white">
            <option value="血压">血压</option>
            <option value="血糖">血糖</option>
            <option value="体温">体温</option>
          </select>
          <input v-model="editForm.value" class="input-primary" />
          <input v-model="editForm.recordDate" type="date" class="input-primary" />
        </div>
        <div class="flex gap-3">
          <button @click="confirmEdit" class="btn-success">保存</button>
          <button @click="cancelEdit" class="btn-secondary">取消</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useAuthStore } from '../stores/auth'
import { ref, onMounted, watch } from 'vue'
import { getHealth, addHealth, updateHealth, deleteHealth } from '../api/health'
import { getFamilyMembers } from '../api/family'
import { getAllUsers } from '../api/user'

const auth = useAuthStore()
const list = ref([])
const members = ref([])
const allUsers = ref([])
const userId = auth.userId
const targetUserId = ref(userId)
const currentUserInfo = ref({ username: '', age: '', gender: '' })
const form = ref({ type: '', value: '', recordDate: '' })
const editing = ref(false)
const editForm = ref({ id: null, type: '', value: '', recordDate: '' })

onMounted(async () => {
  await loadAllUsers()
  await reloadMembers()
  await reloadHealth()
  await updateCurrentUserInfo()
})

// 当 targetUserId 改变时，更新当前用户信息
watch(targetUserId, () => {
  updateCurrentUserInfo()
})

const loadAllUsers = async () => {
  const res = await getAllUsers()
  allUsers.value = res.data || []
}

const reloadMembers = async () => {
  // 加载当前用户的家庭成员列表
  const res = await getFamilyMembers(userId)
  members.value = res.data || []
}

const reloadHealth = async () => {
  const res = await getHealth(targetUserId.value)
  list.value = res.data || []
}

const updateCurrentUserInfo = () => {
  const user = allUsers.value.find(u => u.id === targetUserId.value)
  if (user) {
    currentUserInfo.value = {
      username: user.username,
      age: user.age || '-',
      gender: user.gender || '-'
    }
  } else {
    currentUserInfo.value = { username: '未知', age: '-', gender: '-' }
  }
}

const getMemberUsername = (memberUserId) => {
  const user = allUsers.value.find(u => u.id === memberUserId)
  return user ? user.username : '未知用户'
}

const addRecord = async () => {
  if (!form.value.type || !form.value.value || !form.value.recordDate) {
    alert('请完整填写类型、值和日期')
    return
  }
  const payload = { ...form.value, userId: targetUserId.value }
  await addHealth(payload)
  form.value = { type: '', value: '', recordDate: '' }
  await reloadHealth()
}

const startEdit = (h) => {
  editing.value = true
  editForm.value = { id: h.id, type: h.type, value: h.value, recordDate: h.recordDate }
}

const cancelEdit = () => {
  editing.value = false
  editForm.value = { id: null, type: '', value: '', recordDate: '' }
}

const confirmEdit = async () => {
  const { id, type, value, recordDate } = editForm.value
  if (!id) return
  await updateHealth(id, { type, value, recordDate, userId: targetUserId.value })
  cancelEdit()
  await reloadHealth()
}

const removeRecord = async (id) => {
  if (!confirm('确认删除该记录？')) return
  await deleteHealth(id)
  await reloadHealth()
}
</script>
