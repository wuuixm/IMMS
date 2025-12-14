<template>
  <div>
    <h2 class="title-main">家庭成员管理</h2>

    <!-- 新增成员 -->
    <div class="card-box mb-8">
      <h3 class="title-section">添加成员</h3>
      <div class="flex gap-3">
        <select v-model.number="form.memberUserId" class="input-primary flex-1 bg-white">
          <option value="">请选择用户</option>
          <option v-for="u in allUsers" :key="u.id" :value="u.id">
            {{ u.username }} (年龄: {{ u.age || '-' }}, 性别: {{ u.gender || '-' }})
          </option>
        </select>
        <button @click="addMember" class="btn-primary">新增</button>
      </div>
    </div>

    <!-- 成员列表 -->
    <div class="card-box">
      <table class="table-primary">
        <thead>
          <tr>
            <th>用户名</th>
            <th>年龄</th>
            <th>性别</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="m in list" :key="m.id">
            <td class="font-medium">{{ getMemberUsername(m.memberUserId) }}</td>
            <td>{{ getMemberAge(m.memberUserId) }}</td>
            <td>{{ getMemberGender(m.memberUserId) }}</td>
            <td>
              <button @click="removeMember(m.id)" class="btn-danger">删除</button>
            </td>
          </tr>
        </tbody>
      </table>
      <p v-if="list.length === 0" class="mt-8 text-center text-gray-500">暂无家庭成员</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getFamilyMembers, addFamilyMember, deleteFamilyMember } from '../api/family'
import { getAllUsers } from '../api/user'

const auth = useAuthStore()
const userId = auth.userId

const list = ref([])
const allUsers = ref([])
const form = ref({ memberUserId: '' })

const loadMembers = async () => {
  const res = await getFamilyMembers(userId)
  list.value = res.data || []
}

const loadAllUsers = async () => {
  const res = await getAllUsers()
  allUsers.value = res.data || []
}

onMounted(async () => {
  await loadAllUsers()
  await loadMembers()
})

const addMember = async () => {
  if (!form.value.memberUserId) {
    alert('请选择一个用户')
    return
  }
  await addFamilyMember({ userId, memberUserId: form.value.memberUserId })
  form.value = { memberUserId: '' }
  await loadMembers()
}

const removeMember = async (id) => {
  if (!confirm('确认删除该成员？')) return
  await deleteFamilyMember(id)
  await loadMembers()
}

const getMemberUsername = (memberUserId) => {
  const user = allUsers.value.find(u => u.id === memberUserId)
  return user ? user.username : '未知用户'
}

const getMemberAge = (memberUserId) => {
  const user = allUsers.value.find(u => u.id === memberUserId)
  return user ? user.age || '-' : '-'
}

const getMemberGender = (memberUserId) => {
  const user = allUsers.value.find(u => u.id === memberUserId)
  return user ? user.gender || '-' : '-'
}
</script>
