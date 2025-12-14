<template>
  <div>
    <h2>家庭成员管理</h2>

    <!-- 新增成员 -->
    <div style="margin-bottom: 20px; border: 1px solid #ccc; padding: 12px;">
      <h3>新增成员</h3>
      <label>
        姓名：<input v-model="form.name" />
      </label>
      <label style="margin-left:10px;">
        年龄：<input v-model.number="form.age" type="number" />
      </label>
      <label style="margin-left:10px;">
        性别：
        <select v-model="form.gender">
          <option value="">请选择</option>
          <option value="M">男</option>
          <option value="F">女</option>
        </select>
      </label>
      <button @click="addMember" style="margin-left:10px;">新增</button>
    </div>

    <!-- 成员列表 -->
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr style="background:#f5f5f5;">
          <th style="border:1px solid #ddd; padding:8px;">姓名</th>
          <th style="border:1px solid #ddd; padding:8px;">年龄</th>
          <th style="border:1px solid #ddd; padding:8px;">性别</th>
          <th style="border:1px solid #ddd; padding:8px;">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="m in list" :key="m.id">
          <td style="border:1px solid #ddd; padding:8px;">{{ m.name }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ m.age }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ m.gender }}</td>
          <td style="border:1px solid #ddd; padding:8px;">
            <button @click="startEdit(m)">编辑</button>
            <button @click="removeMember(m.id)" style="color:red; margin-left:8px;">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <!-- 编辑 -->
    <div v-if="editing" style="margin-top:16px; border:1px solid #aaa; padding:12px;">
      <h3>编辑成员</h3>
      <label>
        姓名：<input v-model="editForm.name" />
      </label>
      <label style="margin-left:10px;">
        年龄：<input v-model.number="editForm.age" type="number" />
      </label>
      <label style="margin-left:10px;">
        性别：
        <select v-model="editForm.gender">
          <option value="M">男</option>
          <option value="F">女</option>
        </select>
      </label>
      <button @click="confirmEdit" style="margin-left:10px;">保存</button>
      <button @click="cancelEdit" style="margin-left:6px;">取消</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getFamilyMembers, addFamilyMember, updateFamilyMember, deleteFamilyMember } from '../api/family'

const auth = useAuthStore()
const userId = auth.userId

const list = ref([])
const form = ref({ name: '', age: 0, gender: '' })
const editing = ref(false)
const editForm = ref({ id: null, name: '', age: 0, gender: '' })

const loadMembers = async () => {
  const res = await getFamilyMembers(userId)
  list.value = res.data
}

onMounted(loadMembers)

const addMember = async () => {
  if (!form.value.name || !form.value.gender) {
    alert('请填写姓名和性别')
    return
  }
  await addFamilyMember({ ...form.value, userId })
  form.value = { name: '', age: 0, gender: '' }
  await loadMembers()
}

const startEdit = (m) => {
  editing.value = true
  editForm.value = { id: m.id, name: m.name, age: m.age, gender: m.gender }
}

const cancelEdit = () => {
  editing.value = false
  editForm.value = { id: null, name: '', age: 0, gender: '' }
}

const confirmEdit = async () => {
  const { id, name, age, gender } = editForm.value
  if (!id) return
  await updateFamilyMember(id, { name, age, gender, userId })
  cancelEdit()
  await loadMembers()
}

const removeMember = async (id) => {
  if (!confirm('确认删除该成员？')) return
  await deleteFamilyMember(id)
  await loadMembers()
}
</script>
