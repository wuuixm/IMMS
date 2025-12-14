<template>
  <div>
    <h2 class="title-main">用药提醒</h2>

    <!-- 新增提醒 -->
    <div class="card-box mb-8">
      <h3 class="title-section">创建提醒</h3>
      <div class="flex gap-3">
        <select v-model.number="form.drugId" class="input-primary flex-1 bg-white">
          <option value="">请选择药品</option>
          <option v-for="d in drugs" :key="d.id" :value="d.id">{{ d.name }}</option>
        </select>
        <input v-model="form.remindTime" type="datetime-local" class="input-primary flex-1" />
        <button @click="createReminder" class="btn-primary">创建</button>
      </div>
    </div>

    <!-- 提醒列表 -->
    <div class="card-box">
      <table class="table-primary">
        <thead>
          <tr>
            <th>药品</th>
            <th>提醒时间</th>
            <th>状态</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="r in reminders" :key="r.id">
            <td class="font-medium">{{ getDrugName(r.drugId) }}</td>
            <td class="text-sm">{{ r.remindTime }}</td>
            <td>
              <span :class="r.status === 'DONE' ? 'badge-done' : 'badge-pending'">
                {{ r.status === 'DONE' ? '✓ 已完成' : '◯ 待处理' }}
              </span>
            </td>
            <td class="space-x-2">
              <button 
                @click="markDone(r.id)" 
                :disabled="r.status === 'DONE'"
                :class="r.status === 'DONE' ? 'opacity-50 cursor-not-allowed' : 'btn-success'"
              >
                完成
              </button>
              <button @click="remove(r.id)" class="btn-danger">删除</button>
            </td>
          </tr>
        </tbody>
      </table>

      <p v-if="reminders.length === 0" class="mt-8 text-center text-gray-500 text-lg">暂无提醒</p>
    </div>
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
