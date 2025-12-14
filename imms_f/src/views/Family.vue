<template>
  <div>
    <h2>家庭成员管理</h2>

    <!-- 新增成员 -->
    <div style="margin-bottom: 20px; border: 1px solid #ccc; padding: 12px;">
      <h3>新增成员</h3>
      <label>
        选择用户：
        <select v-model.number="form.memberUserId">
          <option value="">请选择</option>
          <option v-for="u in allUsers" :key="u.id" :value="u.id">
            {{ u.username }} (年龄: {{ u.age || '-' }}, 性别: {{ u.gender || '-' }})
          </option>
        </select>
      </label>
      <button @click="addMember" style="margin-left:10px;">新增</button>
    </div>

    <!-- 成员列表 -->
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr style="background:#f5f5f5;">
          <th style="border:1px solid #ddd; padding:8px;">用户名</th>
          <th style="border:1px solid #ddd; padding:8px;">年龄</th>
          <th style="border:1px solid #ddd; padding:8px;">性别</th>
          <th style="border:1px solid #ddd; padding:8px;">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="m in list" :key="m.id">
          <td style="border:1px solid #ddd; padding:8px;">{{ getMemberUsername(m.memberUserId) }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ getMemberAge(m.memberUserId) }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ getMemberGender(m.memberUserId) }}</td>
          <td style="border:1px solid #ddd; padding:8px;">
            <button @click="removeMember(m.id)" style="color:red;">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <p v-if="list.length === 0" style="margin-top:20px; color:#666;">
      暂无家庭成员
    </p>
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
