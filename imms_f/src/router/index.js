import { createRouter, createWebHistory } from 'vue-router'

import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import DrugList from '../views/DrugList.vue'
import ReminderList from '../views/ReminderList.vue'
import Health from '../views/Health.vue'
import Family from '../views/Family.vue'
import Home from '../views/Home.vue'

const routes = [
    // 默认进入登录页
    { path: '/', redirect: '/login' },
    { path: '/login', component: Login },
    { path: '/register', component: Register },
    { path: '/drugs', component: DrugList },
    { path: '/reminders', component: ReminderList },
    { path: '/health', component: Health }
    , { path: '/family', component: Family }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

// 路由守卫：除登录/注册外都需登录
import { useAuthStore } from '../stores/auth'
router.beforeEach((to, from, next) => {
    const publicPaths = ['/login', '/register']
    if (publicPaths.includes(to.path)) return next()
    const auth = useAuthStore()
    if (!auth.isAuthenticated) return next('/login')
    next()
})

export default router
