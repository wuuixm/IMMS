// src/api/ai-qa-helper.js
// 药品问答助手（前端直连外部AI服务）：
// - 从 src/config/ai-config.json 读取密钥/端点
// - 暴露单一函数：getDrugAIInfo(drug) → 返回“药品要点 + 注意事项”文本

import aiConfig from '../config/ai-config.json'

const SYSTEM_PROMPT = [
    '你是一个药品问答助手，提供药品说明书要点与安全用药建议。',
    '请用简洁中文分点回答，避免使用 Markdown。',
    '优先说明：适应症、用法用量（成人/儿童/老年/孕期/肝肾异常特殊说明）、禁忌与慎用、常见不良反应、重要相互作用、注意事项与储存。'
].join('\n')

function buildMessagesFromDrug(drug = {}) {
    const fields = [
        drug?.name ? `药品名：${drug.name}` : null,
        drug?.genericName ? `通用名：${drug.genericName}` : null,
        drug?.category ? `分类：${drug.category}` : null,
        drug?.ingredients ? `成分：${drug.ingredients}` : null,
        drug?.indications ? `适应症：${drug.indications}` : null,
        drug?.contraindications ? `禁忌：${drug.contraindications}` : null,
        drug?.cautions ? `注意事项：${drug.cautions}` : null
    ].filter(Boolean).join('\n')

    const contextText = fields ? `已知药品信息：\n${fields}\n` : ''
    const userContent = `${contextText}请给出本药的要点总结与注意事项，按要点分条输出。`

    return [
        { role: 'system', content: SYSTEM_PROMPT },
        { role: 'user', content: userContent }
    ]
}

// 对接星火开放平台兼容格式（或你的兼容端点），非流式
export async function getDrugAIInfo(drug) {
    const apiKey = aiConfig?.apiKey || ''
    const endpoint = aiConfig?.endpoint || ''
    const model = aiConfig?.model || 'lite'
    const temperature = aiConfig?.temperature ?? 0.4
    const maxTokens = aiConfig?.maxTokens ?? 800

    if (!apiKey) return '错误: 未配置 API 密钥（请在 src/config/ai-config.json 中填写 apiKey）'
    if (!endpoint) return '错误: 未配置 AI 接口地址（endpoint）'

    const messages = buildMessagesFromDrug(drug)
    const body = {
        model,
        user: 'imms-frontend',
        messages,
        temperature,
        max_tokens: maxTokens,
        stream: false
    }

    try {
        const res = await fetch(endpoint, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${apiKey}`
            },
            body: JSON.stringify(body)
        })

        if (!res.ok) {
            let errText = '未知错误'
            try { errText = await res.text() } catch { }
            throw new Error(`API错误: ${res.status} - ${errText}`)
        }
        const result = await res.json()
        return result?.choices?.[0]?.message?.content || '无响应'
    } catch (e) {
        const msg = e instanceof Error ? e.message : String(e)
        return `错误: ${msg}`
    }
}

// 可选导出：若页面需要先构造 messages 再自定义发送
export function buildDrugMessages(drug) {
    return buildMessagesFromDrug(drug)
}
