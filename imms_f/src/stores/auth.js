import { defineStore } from 'pinia'

export const useAuthStore = defineStore('auth', {
    state: () => ({
        user: null
    }),
    getters: {
        isAuthenticated: (state) => !!(state.user && state.user.id),
        userId: (state) => state.user?.id
    },
    actions: {
        setUser(u) {
            this.user = u
        },
        logout() {
            this.user = null
        }
    }
})
