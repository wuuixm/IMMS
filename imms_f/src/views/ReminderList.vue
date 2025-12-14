<template>
  <div>
    <h2>用药提醒</h2>

    <ul>
      <li v-for="r in reminders" :key="r.id">
        药品ID: {{ r.drugId }} | 时间: {{ r.remindTime }} | 状态: {{ r.status }}
      </li>
    </ul>
  </div>
</template>

<script setup>
import { useAuthStore } from '../stores/auth'
import { ref, onMounted } from 'vue'
import { getReminders } from '../api/reminder'

const auth = useAuthStore()
const reminders = ref([])
const userId = auth.userId

onMounted(async () => {
  const res = await getReminders(userId)
  reminders.value = res.data
})
</script>
