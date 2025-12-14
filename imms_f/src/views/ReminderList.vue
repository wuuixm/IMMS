<template>
  <div>
    <h2>用药提醒</h2>

    <!-- 新增提醒 -->
    <div style="margin-bottom:16px; border:1px solid #ccc; padding:12px;">
      <h3>创建提醒</h3>
      <label>
        药品：
        <select v-model.number="form.drugId">
          <option value="">请选择药品</option>
          <option v-for="d in drugs" :key="d.id" :value="d.id">{{ d.name }}</option>
        </select>
      </label>
      <label style="margin-left:10px;">
        时间：
        <input v-model="form.remindTime" type="datetime-local" />
      </label>
      <button @click="createReminder" style="margin-left:10px;">创建</button>
    </div>

    <!-- 提醒列表 -->
    <table style="width:100%; border-collapse:collapse;">
      <thead>
        <tr style="background:#f5f5f5;">
          <th style="border:1px solid #ddd; padding:8px;">药品</th>
          <th style="border:1px solid #ddd; padding:8px;">时间</th>
          <th style="border:1px solid #ddd; padding:8px;">状态</th>
          <th style="border:1px solid #ddd; padding:8px;">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="r in reminders" :key="r.id">
          <td style="border:1px solid #ddd; padding:8px;">{{ getDrugName(r.drugId) }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ r.remindTime }}</td>
          <td style="border:1px solid #ddd; padding:8px;">{{ r.status }}</td>
          <td style="border:1px solid #ddd; padding:8px;">
            <button @click="markDone(r.id)" :disabled="r.status === 'DONE'">完成</button>
            <button @click="remove(r.id)" style="margin-left:8px; color:red;">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <p v-if="reminders.length === 0" style="margin-top:10px; color:#666;">暂无提醒</p>
  </div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useAuthStore } from '../stores/auth'
import { getReminders, addReminder, deleteReminder, updateReminderStatus } from '../api/reminder'
import { getDrugs } from '../api/drug'

const auth = useAuthStore()
const userId = auth.userId
const reminders = ref([])
const drugs = ref([])
const form = ref({ drugId: '', remindTime: '' })
const alerted = new Set()
let timer = null

const loadDrugs = async () => {
  const res = await getDrugs()
  drugs.value = res.data || []
}

const loadReminders = async () => {
  const res = await getReminders(userId)
  reminders.value = res.data || []
}

onMounted(async () => {
  await loadDrugs()
  await loadReminders()
  startTimer()
})

onBeforeUnmount(() => {
  if (timer) clearInterval(timer)
})

const createReminder = async () => {
  if (!form.value.drugId || !form.value.remindTime) {
    alert('请选择药品并设置提醒时间')
    return
  }
  const payload = {
    userId,
    drugId: form.value.drugId,
    remindTime: form.value.remindTime,
    status: 'PENDING'
  }
  await addReminder(payload)
  form.value = { drugId: '', remindTime: '' }
  await loadReminders()
}

const markDone = async (id) => {
  await updateReminderStatus(id, 'DONE')
  await loadReminders()
}

const remove = async (id) => {
  if (!confirm('确认删除该提醒？')) return
  await deleteReminder(id)
  await loadReminders()
}

const getDrugName = (id) => {
  const d = drugs.value.find(x => x.id === id)
  return d ? d.name : `药品ID:${id}`
}

const startTimer = () => {
  timer = setInterval(checkDue, 30000) // 每30秒检查一次
}

const checkDue = async () => {
  const now = new Date()
  for (const r of reminders.value) {
    if (r.status === 'DONE') continue
    const time = new Date(r.remindTime)
    if (time <= now && !alerted.has(r.id)) {
      alert(`请服用 ${getDrugName(r.drugId)}，时间已到：${r.remindTime}`)
      alerted.add(r.id)
      await updateReminderStatus(r.id, 'DONE')
      await loadReminders()
    }
  }
}
</script>
