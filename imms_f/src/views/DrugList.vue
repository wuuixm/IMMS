<template>
  <div>
    <h2 class="title-main">药品管理</h2>

    <!-- 分类管理部分 -->
    <div class="card-box mb-8">
      <h3 class="title-section">药品分类</h3>
      
      <!-- 新增分类 -->
      <div class="flex gap-3 mb-6">
        <input v-model="newCategoryName" placeholder="输入分类名称" class="input-primary flex-1" />
        <button @click="addNewCategory" class="btn-primary">新增分类</button>
      </div>

      <!-- 分类列表 -->
      <div class="flex flex-wrap gap-2">
        <button 
          @click="selectedCategoryId = null"
          :class="selectedCategoryId === null ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'"
          class="px-5 py-2 rounded-full font-semibold hover:shadow-md transition-all"
        >
          全部药品
        </button>
        <button
          v-for="cat in categories"
          :key="cat.id"
          @click="selectedCategoryId = cat.id"
          :class="selectedCategoryId === cat.id ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700'"
          class="px-5 py-2 rounded-full font-semibold hover:shadow-md transition-all flex items-center gap-2"
        >
          {{ cat.name }}
          <span @click.stop="handleDeleteCategory(cat.id)" class="cursor-pointer hover:font-bold ml-1">✕</span>
        </button>
      </div>
    </div>

    <!-- 药品管理部分 -->
    <div class="card-box">
      <h3 class="title-section">药品列表</h3>
      
      <!-- 新增药品 -->
      <div class="mb-8 bg-gradient-to-r from-gray-50 to-gray-100 rounded-lg p-5 border border-gray-200">
        <h4 class="font-semibold mb-4 text-gray-900">新增药品</h4>
        <div class="grid grid-cols-4 gap-3">
          <input v-model="newDrug.name" placeholder="药品名称" class="input-primary" />
          <input v-model.number="newDrug.stock" type="number" placeholder="库存数量" class="input-primary" />
          <select v-model.number="newDrug.categoryId" class="input-primary bg-white">
            <option value="">请选择分类</option>
            <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
          </select>
          <button @click="addNewDrug" class="btn-primary">新增</button>
        </div>
      </div>

      <!-- 药品列表 -->
      <table class="table-primary">
        <thead>
          <tr>
            <th>ID</th>
            <th>药品名称</th>
            <th>分类</th>
            <th>库存</th>
            <th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="drug in displayedDrugs" :key="drug.id">
            <td class="font-mono text-sm">{{ drug.id }}</td>
            <td class="font-medium">
              <button class="text-blue-600 hover:underline" @click="showDrugAI(drug)">
                {{ drug.name }}
              </button>
            </td>
            <td>{{ getCategoryName(drug.categoryId) }}</td>
            <td>
              <input 
                v-model.number="editingStock[drug.id]" 
                type="number" 
                @change="updateStock(drug.id)"
                class="w-20 border border-gray-300 rounded px-2 py-1 text-center"
              />
            </td>
            <td>
              <button @click="handleDeleteDrug(drug.id)" class="btn-danger">删除</button>
            </td>
          </tr>
        </tbody>
      </table>

      <p v-if="displayedDrugs.length === 0" class="mt-8 text-center text-gray-500 text-lg">暂无药品数据</p>

      <!-- AI 药品说明面板 -->
      <div v-if="selectedDrugForAI" class="mt-6 p-4 border rounded bg-white shadow-sm">
        <div class="flex items-center justify-between mb-2">
          <h4 class="font-semibold">AI 药品说明：{{ selectedDrugForAI.name }}</h4>
          <button class="text-gray-500 hover:text-gray-700" @click="selectedDrugForAI=null">关闭</button>
        </div>
        <div class="text-sm leading-6 whitespace-pre-wrap">
          <span v-if="aiLoading">正在获取，请稍候…</span>
          <span v-else>{{ aiAnswer }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getDrugAIInfo } from '../api/ai-qa-helper'
import { 
  getDrugs, 
  getDrugsByCategory, 
  addDrug, 
  deleteDrug, 
  updateDrugStock,
  getCategories,
  addCategory,
  deleteCategory
} from '../api/drug'

// 状态
const drugs = ref([])
const categories = ref([])
const selectedCategoryId = ref(null)
const newDrug = ref({ name: '', stock: 0, categoryId: '' })
const newCategoryName = ref('')
const editingStock = ref({})

// AI 展示状态
const selectedDrugForAI = ref(null)
const aiAnswer = ref('')
const aiLoading = ref(false)

// 计算属性：根据选中的分类筛选药品
const displayedDrugs = computed(() => {
  if (selectedCategoryId.value === null) {
    return drugs.value
  }
  return drugs.value.filter(d => d.categoryId === selectedCategoryId.value)
})

// 初始化：加载分类和药品
onMounted(async () => {
  await loadCategories()
  await loadDrugs()
})

// 加载分类
const loadCategories = async () => {
  try {
    const res = await getCategories()
    categories.value = res.data || []
  } catch (error) {
    console.error('加载分类失败', error)
  }
}

// 加载药品
const loadDrugs = async () => {
  try {
    const res = await getDrugs()
    drugs.value = res.data || []
    // 初始化库存编辑对象
    editingStock.value = {}
    drugs.value.forEach(d => {
      editingStock.value[d.id] = d.stock
    })
  } catch (error) {
    console.error('加载药品失败', error)
  }
}

// 新增分类
const addNewCategory = async () => {
  if (!newCategoryName.value.trim()) {
    alert('请输入分类名称')
    return
  }
  try {
    await addCategory(newCategoryName.value)
    newCategoryName.value = ''
    await loadCategories()
  } catch (error) {
    console.error('新增分类失败', error)
    alert('新增分类失败')
  }
}

// 删除分类（本地方法，避免与导入的 API 重名）
const handleDeleteCategory = async (id) => {
  if (!confirm('确定删除此分类吗？')) return
  try {
    await deleteCategory(id)
    await loadCategories()
  } catch (error) {
    console.error('删除分类失败', error)
    alert('删除分类失败')
  }
}

// 新增药品
const addNewDrug = async () => {
  if (!newDrug.value.name.trim()) {
    alert('请输入药品名称')
    return
  }
  if (newDrug.value.stock <= 0) {
    alert('请输入有效的库存数量')
    return
  }
  try {
    await addDrug({
      name: newDrug.value.name,
      stock: newDrug.value.stock,
      categoryId: newDrug.value.categoryId || null
    })
    newDrug.value = { name: '', stock: 0, categoryId: '' }
    await loadDrugs()
  } catch (error) {
    console.error('新增药品失败', error)
    alert('新增药品失败')
  }
}

// 删除药品（本地方法，避免与导入的 API 重名）
const handleDeleteDrug = async (id) => {
  if (!confirm('确定删除此药品吗？')) return
  try {
    await deleteDrug(id)
    await loadDrugs()
  } catch (error) {
    console.error('删除药品失败', error)
    alert('删除药品失败')
  }
}

// 更新库存
const updateStock = async (drugId) => {
  const newStock = editingStock.value[drugId]
  try {
    await updateDrugStock(drugId, newStock)
    await loadDrugs()
  } catch (error) {
    console.error('更新库存失败', error)
    alert('更新库存失败')
  }
}

// 获取分类名称
const getCategoryName = (categoryId) => {
  if (!categoryId) return '未分类'
  const cat = categories.value.find(c => c.id === categoryId)
  return cat ? cat.name : '未分类'
}

// 点击药品名称，获取 AI 说明
const showDrugAI = async (drug) => {
  selectedDrugForAI.value = drug
  aiAnswer.value = ''
  aiLoading.value = true
  const answer = await getDrugAIInfo({
    name: drug?.name,
    category: getCategoryName(drug?.categoryId)
  })
  aiAnswer.value = answer
  aiLoading.value = false
}
</script>
