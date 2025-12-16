/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : PostgreSQL
 Source Server Version : 180000 (180000)
 Source Host           : localhost:5432
 Source Catalog        : imms
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 180000 (180000)
 File Encoding         : 65001

 Date: 16/12/2025 18:38:01
*/


-- ----------------------------
-- Sequence structure for drug_category_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drug_category_id_seq";
CREATE SEQUENCE "public"."drug_category_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for drug_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."drug_id_seq";
CREATE SEQUENCE "public"."drug_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for family_member_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."family_member_id_seq";
CREATE SEQUENCE "public"."family_member_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for reminder_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."reminder_id_seq";
CREATE SEQUENCE "public"."reminder_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for sys_user_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sys_user_id_seq";
CREATE SEQUENCE "public"."sys_user_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS "public"."drug";
CREATE TABLE "public"."drug" (
  "id" int8 NOT NULL DEFAULT nextval('drug_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "category_id" int8,
  "description" text COLLATE "pg_catalog"."default",
  "stock" int4 DEFAULT 0
)
;

-- ----------------------------
-- Table structure for drug_category
-- ----------------------------
DROP TABLE IF EXISTS "public"."drug_category";
CREATE TABLE "public"."drug_category" (
  "id" int8 NOT NULL DEFAULT nextval('drug_category_id_seq'::regclass),
  "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for family_member
-- ----------------------------
DROP TABLE IF EXISTS "public"."family_member";
CREATE TABLE "public"."family_member" (
  "id" int8 NOT NULL DEFAULT nextval('family_member_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "member_user_id" int8 NOT NULL
)
;

-- ----------------------------
-- Table structure for health_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."health_record";
CREATE TABLE "public"."health_record" (
  "id" int8 NOT NULL,
  "userId" int8 NOT NULL,
  "type" varchar(255) COLLATE "pg_catalog"."default",
  "value" varchar(255) COLLATE "pg_catalog"."default",
  "recordDate" timestamp(6),
  "record_date" date,
  "user_id" int8 NOT NULL
)
;

-- ----------------------------
-- Table structure for reminder
-- ----------------------------
DROP TABLE IF EXISTS "public"."reminder";
CREATE TABLE "public"."reminder" (
  "id" int8 NOT NULL DEFAULT nextval('reminder_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "drug_id" int8 NOT NULL,
  "remind_time" timestamp(6) NOT NULL,
  "status" varchar(20) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
  "id" int8 NOT NULL DEFAULT nextval('sys_user_id_seq'::regclass),
  "username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "role" varchar(20) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "age" int4,
  "gender" varchar(10) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."drug_category_id_seq"
OWNED BY "public"."drug_category"."id";
SELECT setval('"public"."drug_category_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."drug_id_seq"
OWNED BY "public"."drug"."id";
SELECT setval('"public"."drug_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."family_member_id_seq"
OWNED BY "public"."family_member"."id";
SELECT setval('"public"."family_member_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."reminder_id_seq"
OWNED BY "public"."reminder"."id";
SELECT setval('"public"."reminder_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sys_user_id_seq"
OWNED BY "public"."sys_user"."id";
SELECT setval('"public"."sys_user_id_seq"', 5, true);

-- ----------------------------
-- Indexes structure for table drug
-- ----------------------------
CREATE INDEX "UX_name" ON "public"."drug" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table drug
-- ----------------------------
ALTER TABLE "public"."drug" ADD CONSTRAINT "drug_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table drug_category
-- ----------------------------
CREATE INDEX "UX_category_name" ON "public"."drug_category" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table drug_category
-- ----------------------------
ALTER TABLE "public"."drug_category" ADD CONSTRAINT "drug_category_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table family_member
-- ----------------------------
ALTER TABLE "public"."family_member" ADD CONSTRAINT "family_member_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table health_record
-- ----------------------------
ALTER TABLE "public"."health_record" ADD CONSTRAINT "health_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table reminder
-- ----------------------------
ALTER TABLE "public"."reminder" ADD CONSTRAINT "reminder_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_user
-- ----------------------------
CREATE INDEX "UX_username" ON "public"."sys_user" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_username_key" UNIQUE ("username");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "sys_user_pkey" PRIMARY KEY ("id");
