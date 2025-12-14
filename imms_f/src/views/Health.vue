<template>
  <div>
    <h2>健康信息</h2>

    <!-- 选择查看对象：本人或家庭成员 -->
    <div style="margin-bottom: 12px; border: 1px solid #ccc; padding: 10px;">
      <label>
        查看对象：
        <select v-model.number="targetUserId" @change="reloadHealth">
          <option :value="auth.userId">本人</option>
          <option v-for="m in members" :key="m.id" :value="m.memberUserId">{{ getMemberUsername(m.memberUserId) }}（成员）</option>
        </select>
      </label>
    </div>

    <!-- 显示当前选中用户的信息 -->
    <div style="margin-bottom: 16px; border: 1px solid #aaa; padding: 12px; background:#f9f9f9;">
      <h3>当前用户信息</h3>
      <p><strong>用户名：</strong>{{ currentUserInfo.username || '未知' }}</p>
      <p><strong>年龄：</strong>{{ currentUserInfo.age || '-' }}</p>
      <p><strong>性别：</strong>{{ currentUserInfo.gender || '-' }}</p>
    </div>

    <!-- 新增健康记录 -->
    <div style="margin-bottom: 20px; border: 1px solid #ccc; padding: 12px;">
      <h3>新增记录</h3>
      <label>
        类型：
        <select v-model="form.type">
          <option value="">请选择</option>
          <option value="血压">血压</option>
          <option value="血糖">血糖</option>
          <option value="体温">体温</option>
        </select>
      </label>
      <label style="margin-left:10px;">
        值：<input v-model="form.value" placeholder="如 120/80 或 5.6 或 36.5" />
      </label>
      <label style="margin-left:10px;">
        日期：<input v-model="form.recordDate" type="date" />
      </label>
      <button @click="addRecord" style="margin-left:10px;">新增</button>
    </div>

    <!-- 记录列表 -->
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr style="background:#f5f5f5;">
          <th style="border:1px solid #ddd; padding:8px;">类型</th>
          <th style="border:1px solid #ddd; padding:8px;">值</th>
          <th style="border:1px solid #ddd; padding:8px;">日期</th>
          <th style="border:1px solid #ddd; padding:8px;">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="h in list" :key="h.id">
          <td style="border:1px solid #ddd; padding:8px;">{{ h.type }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ h.value }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ h.recordDate }}</td>
          <td style="border:1px solid #ddd; padding:8px;">
            <button @click="startEdit(h)">编辑</button>
            <button @click="removeRecord(h.id)" style="color:red; margin-left:8px;">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <!-- 编辑弹窗（简易版） -->
    <div v-if="editing" style="margin-top:16px; border:1px solid #aaa; padding:12px;">
      <h3>编辑记录</h3>
      <label>
        类型：
        <select v-model="editForm.type">
          <option value="血压">血压</option>
          <option value="血糖">血糖</option>
          <option value="体温">体温</option>
        </select>
      </label>
      <label style="margin-left:10px;">
        值：<input v-model="editForm.value" />
      </label>
      <label style="margin-left:10px;">
        日期：<input v-model="editForm.recordDate" type="date" />
      </label>
      <button @click="confirmEdit" style="margin-left:10px;">保存</button>
      <button @click="cancelEdit" style="margin-left:6px;">取消</button>
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
