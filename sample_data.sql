-- IMMS seed data for PostgreSQL
-- Inserts drug categories and many drugs with idempotent statements
-- Safe to run multiple times (checks by name)

BEGIN;

-- ==========================
-- Drug Categories (去重插入)
-- ==========================
INSERT INTO "public"."drug_category" ("name")
SELECT '解热镇痛' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='解热镇痛');
INSERT INTO "public"."drug_category" ("name")
SELECT '感冒用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='感冒用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '咳嗽祛痰' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='咳嗽祛痰');
INSERT INTO "public"."drug_category" ("name")
SELECT '消化系统用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='消化系统用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '抗感染用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='抗感染用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '心脑血管用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='心脑血管用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '维生素与矿物质' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='维生素与矿物质');
INSERT INTO "public"."drug_category" ("name")
SELECT '皮肤科用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='皮肤科用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '眼科用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='眼科用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '耳鼻喉用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='耳鼻喉用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '过敏用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='过敏用药');
INSERT INTO "public"."drug_category" ("name")
SELECT '糖尿病用药' WHERE NOT EXISTS (SELECT 1 FROM "public"."drug_category" WHERE "name"='糖尿病用药');

-- ==========================
-- Drugs (每条名称去重 + 分类按名称关联)
-- ==========================
-- 解热镇痛（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '对乙酰氨基酚片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='解热镇痛'),'解热镇痛，缓解发热及轻中度疼痛',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='对乙酰氨基酚片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '布洛芬缓释胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='解热镇痛'),'NSAID，用于头痛、牙痛、经痛等',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='布洛芬缓释胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '萘普生片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='解热镇痛'),'NSAID，缓解肌肉骨骼疼痛',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='萘普生片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '双氯芬酸钠缓释胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='解热镇痛'),'NSAID，抗炎镇痛',150
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='双氯芬酸钠缓释胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '吲哚美辛肠溶片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='解热镇痛'),'抗炎镇痛，餐后用药',120
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='吲哚美辛肠溶片');

-- 感冒用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '复方氨酚那敏片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='感冒用药'),'缓解感冒引起的发热、鼻塞、头痛',400
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='复方氨酚那敏片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '伪麻黄碱对乙酰氨基酚片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='感冒用药'),'含伪麻，缓解鼻塞与发热',220
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='伪麻黄碱对乙酰氨基酚片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '感冒清热颗粒',(SELECT "id" FROM "public"."drug_category" WHERE "name"='感冒用药'),'中成药，清热解表',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='感冒清热颗粒');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '连花清瘟胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='感冒用药'),'中成药，宣肺泄热解毒',240
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='连花清瘟胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '苯海拉明片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='感冒用药'),'第一代抗组胺药，嗜睡',140
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='苯海拉明片');

-- 咳嗽祛痰（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氨溴索口服溶液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='咳嗽祛痰'),'粘液促排药，稀释痰液',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氨溴索口服溶液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '盐酸溴己新片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='咳嗽祛痰'),'祛痰药，改善咳痰困难',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='盐酸溴己新片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '右美沙芬愈创甘油醚口服溶液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='咳嗽祛痰'),'镇咳祛痰复方制剂',210
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='右美沙芬愈创甘油醚口服溶液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '复方甘草片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='咳嗽祛痰'),'镇咳祛痰，含甘草成分',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='复方甘草片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '羧甲司坦片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='咳嗽祛痰'),'化痰药，改善慢性咳嗽痰多',150
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='羧甲司坦片');

-- 消化系统用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '奥美拉唑肠溶胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='消化系统用药'),'PPI，抑酸用于胃溃疡/反流',380
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='奥美拉唑肠溶胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '兰索拉唑胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='消化系统用药'),'PPI，胃食管反流',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='兰索拉唑胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '枸橼酸莫沙必利片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='消化系统用药'),'促胃肠动力药，餐前服',220
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='枸橼酸莫沙必利片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '多潘立酮片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='消化系统用药'),'止吐促动力，短期用',160
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='多潘立酮片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '蒙脱石散',(SELECT "id" FROM "public"."drug_category" WHERE "name"='消化系统用药'),'止泻保护胃肠黏膜',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='蒙脱石散');

-- 抗感染用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿莫西林胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='抗感染用药'),'青霉素类，细菌感染一线',420
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿莫西林胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿莫西林克拉维酸钾片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='抗感染用药'),'β-内酰胺酶抑制复方',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿莫西林克拉维酸钾片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '头孢克肟胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='抗感染用药'),'头孢菌素，呼吸道/泌尿道感染',240
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='头孢克肟胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '左氧氟沙星片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='抗感染用药'),'喹诺酮类，注意禁忌',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='左氧氟沙星片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿奇霉素分散片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='抗感染用药'),'大环内酯类，上呼吸道感染',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿奇霉素分散片');

-- 心脑血管用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿司匹林肠溶片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='心脑血管用药'),'抗血小板，心脑血管二级预防',500
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿司匹林肠溶片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氯吡格雷片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='心脑血管用药'),'抗血小板，与阿司匹林联用常见',240
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氯吡格雷片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿托伐他汀钙片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='心脑血管用药'),'他汀类降脂',360
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿托伐他汀钙片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氨氯地平片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='心脑血管用药'),'钙拮抗剂，降压一线',380
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氨氯地平片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '硝酸甘油片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='心脑血管用药'),'硝酸酯类，急性心绞痛',160
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='硝酸甘油片');

-- 维生素与矿物质（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '维生素C片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='维生素与矿物质'),'补充维生素C，抗氧化',420
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='维生素C片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '维生素B族片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='维生素与矿物质'),'B族复合维生素',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='维生素B族片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '维生素D3胶囊',(SELECT "id" FROM "public"."drug_category" WHERE "name"='维生素与矿物质'),'补充维生素D，助吸收钙',280
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='维生素D3胶囊');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '碳酸钙D3片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='维生素与矿物质'),'补钙与维生素D',350
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='碳酸钙D3片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '叶酸片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='维生素与矿物质'),'妊娠期补充常用',190
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='叶酸片');

-- 皮肤科用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '克霉唑乳膏',(SELECT "id" FROM "public"."drug_category" WHERE "name"='皮肤科用药'),'皮肤真菌感染外用',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='克霉唑乳膏');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '酮康唑洗剂',(SELECT "id" FROM "public"."drug_category" WHERE "name"='皮肤科用药'),'去屑止痒，脂溢性皮炎',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='酮康唑洗剂');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '莫匹罗星软膏',(SELECT "id" FROM "public"."drug_category" WHERE "name"='皮肤科用药'),'外用抗菌软膏',200
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='莫匹罗星软膏');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '糠酸莫米松乳膏',(SELECT "id" FROM "public"."drug_category" WHERE "name"='皮肤科用药'),'外用激素，短期小面积使用',160
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='糠酸莫米松乳膏');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氢化可的松乳膏',(SELECT "id" FROM "public"."drug_category" WHERE "name"='皮肤科用药'),'低效激素，湿疹皮炎',140
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氢化可的松乳膏');

-- 眼科用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '左氧氟沙星滴眼液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='眼科用药'),'抗菌滴眼液',220
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='左氧氟沙星滴眼液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '滴眼用氯霉素',(SELECT "id" FROM "public"."drug_category" WHERE "name"='眼科用药'),'抗菌滴眼液',160
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='滴眼用氯霉素');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '羟丙甲纤维素滴眼液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='眼科用药'),'人工泪液，缓解干眼',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='羟丙甲纤维素滴眼液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '托布霉素地塞米松滴眼液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='眼科用药'),'抗菌+激素复方',140
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='托布霉素地塞米松滴眼液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '奥洛他定滴眼液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='眼科用药'),'抗过敏滴眼液',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='奥洛他定滴眼液');

-- 耳鼻喉用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '布地奈德鼻喷雾剂',(SELECT "id" FROM "public"."drug_category" WHERE "name"='耳鼻喉用药'),'鼻用激素，过敏性鼻炎',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='布地奈德鼻喷雾剂');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氟替卡松鼻喷雾剂',(SELECT "id" FROM "public"."drug_category" WHERE "name"='耳鼻喉用药'),'鼻用激素，减轻鼻塞喷嚏',200
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氟替卡松鼻喷雾剂');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '复方薄荷脑滴鼻液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='耳鼻喉用药'),'缓解鼻塞，短期使用',150
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='复方薄荷脑滴鼻液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '羟甲唑啉滴鼻液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='耳鼻喉用药'),'血管收缩滴鼻剂，≤3天',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='羟甲唑啉滴鼻液');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '地塞米松滴耳液',(SELECT "id" FROM "public"."drug_category" WHERE "name"='耳鼻喉用药'),'外耳道炎症止痒',120
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='地塞米松滴耳液');

-- 过敏用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '氯雷他定片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='过敏用药'),'第二代抗组胺，嗜睡少',420
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='氯雷他定片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '西替利嗪片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='过敏用药'),'第二代抗组胺',300
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='西替利嗪片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '非索非那定片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='过敏用药'),'第二代抗组胺',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='非索非那定片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '地氯雷他定片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='过敏用药'),'第二代抗组胺',180
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='地氯雷他定片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '酮替芬片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='过敏用药'),'肥大细胞稳定剂',160
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='酮替芬片');

-- 糖尿病用药（5）
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '二甲双胍片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='糖尿病用药'),'一线口服降糖药（双胍类）',500
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='二甲双胍片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '格列美脲片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='糖尿病用药'),'磺脲类口服降糖药',240
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='格列美脲片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '阿卡波糖片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='糖尿病用药'),'α-糖苷酶抑制剂，餐前用',260
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='阿卡波糖片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '达格列净片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='糖尿病用药'),'SGLT2抑制剂，注意脱水风险',200
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='达格列净片');
INSERT INTO "public"."drug" ("name","category_id","description","stock")
SELECT '西格列汀片',(SELECT "id" FROM "public"."drug_category" WHERE "name"='糖尿病用药'),'DPP-4抑制剂',220
WHERE NOT EXISTS (SELECT 1 FROM "public"."drug" WHERE "name"='西格列汀片');

COMMIT;

-- 提示：
-- 1) 本脚本适用于 PostgreSQL 并使用 public 架构。
-- 2) 可多次执行，不会因重复名称而新增重复数据。
-- 3) 执行示例（Windows，已配置 psql 环境变量）：
--    psql -h localhost -U <username> -d imms -f sample_data.sql
--    或在图形工具中直接运行本文件。
