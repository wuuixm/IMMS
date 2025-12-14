<template>
  <div>
    <h2>药品管理</h2>

    <!-- 分类管理部分 -->
    <div style="margin-bottom: 30px; border: 1px solid #ccc; padding: 15px;">
      <h3>药品分类管理</h3>
      
      <!-- 新增分类 -->
      <div style="margin-bottom: 15px;">
        <input v-model="newCategoryName" placeholder="输入分类名称" />
        <button @click="addNewCategory">新增分类</button>
      </div>

      <!-- 分类列表 -->
      <div style="margin-bottom: 15px;">
        <button 
          @click="selectedCategoryId = null"
          :style="{ backgroundColor: selectedCategoryId === null ? '#007bff' : '#6c757d', color: '#fff' }"
        >
          全部药品
        </button>
        <button
          v-for="cat in categories"
          :key="cat.id"
          @click="selectedCategoryId = cat.id"
          :style="{ 
            backgroundColor: selectedCategoryId === cat.id ? '#007bff' : '#6c757d',
            color: '#fff',
            marginLeft: '5px'
          }"
        >
          {{ cat.name }}
          <span @click.stop="handleDeleteCategory(cat.id)" style="margin-left: 5px; cursor: pointer;">✕</span>
        </button>
      </div>
    </div>

    <!-- 药品管理部分 -->
    <div style="border: 1px solid #ccc; padding: 15px;">
      <h3>药品列表</h3>
      
      <!-- 新增药品 -->
      <div style="margin-bottom: 20px; background: #f5f5f5; padding: 15px;">
        <h4>新增药品</h4>
        <div>
          <label>
            药品名称: <input v-model="newDrug.name" placeholder="名称" />
          </label>
          <label style="margin-left: 10px;">
            库存: <input v-model.number="newDrug.stock" type="number" placeholder="数量" />
          </label>
          <label style="margin-left: 10px;">
            分类:
            <select v-model.number="newDrug.categoryId">
              <option value="">请选择分类</option>
              <option v-for="cat in categories" :key="cat.id" :value="cat.id">
                {{ cat.name }}
              </option>
            </select>
          </label>
          <button @click="addNewDrug" style="margin-left: 10px;">新增</button>
        </div>
      </div>

      <!-- 药品列表 -->
      <table style="width: 100%; border-collapse: collapse;">
        <thead>
          <tr style="background: #f5f5f5;">
            <th style="border: 1px solid #ddd; padding: 8px;">ID</th>
            <th style="border: 1px solid #ddd; padding: 8px;">药品名称</th>
            <th style="border: 1px solid #ddd; padding: 8px;">分类</th>
            <th style="border: 1px solid #ddd; padding: 8px;">库存</th>
            <th style="border: 1px solid #ddd; padding: 8px;">操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="drug in displayedDrugs" :key="drug.id" style="border: 1px solid #ddd;">
            <td style="border: 1px solid #ddd; padding: 8px;">{{ drug.id }}</td>
            <td style="border: 1px solid #ddd; padding: 8px;">{{ drug.name }}</td>
            <td style="border: 1px solid #ddd; padding: 8px;">{{ getCategoryName(drug.categoryId) }}</td>
            <td style="border: 1px solid #ddd; padding: 8px;">
              <input 
                v-model.number="editingStock[drug.id]" 
                type="number" 
                @change="updateStock(drug.id)"
                style="width: 60px;"
              />
            </td>
            <td style="border: 1px solid #ddd; padding: 8px;">
              <button @click="handleDeleteDrug(drug.id)" style="color: red;">删除</button>
            </td>
          </tr>
        </tbody>
      </table>

      <p v-if="displayedDrugs.length === 0" style="margin-top: 20px; color: #666;">
        暂无药品数据
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
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
</script>
