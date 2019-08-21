# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_28_055925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "blktbs", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "pobjects_id_tbl", precision: 38
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.datetime "updated_at", precision: 6
    t.string "seltbls", limit: 4000
    t.string "contents", limit: 4000
    t.index ["pobjects_id_tbl"], name: "blktbs_ukys1", unique: true
  end

  create_table "blkukys", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "seqno", precision: 38
    t.decimal "tblfields_id", precision: 38
    t.string "grp", limit: 10
    t.index ["grp", "tblfields_id"], name: "blkukys_ukys1", unique: true
  end

  create_table "buttons", id: :decimal, precision: 38, force: :cascade do |t|
    t.date "expiredate"
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "seqno", precision: 38
    t.string "caption", limit: 20
    t.string "title", limit: 30
    t.string "buttonicon", limit: 40
    t.string "onclickbutton", limit: 4000
    t.string "getgridparam", limit: 10
    t.string "editgridrow", limit: 4000
    t.string "aftershowform", limit: 4000
    t.string "code", limit: 50
  end

  create_table "chilscreens", id: :decimal, precision: 38, force: :cascade do |t|
    t.date "expiredate"
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "screenfields_id", precision: 38
    t.decimal "screenfields_id_ch", precision: 38
    t.string "grp", limit: 10
  end

  create_table "fieldcodes", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "pobjects_id_fld", precision: 38
    t.string "ftype", limit: 15
    t.decimal "fieldlength", precision: 38
    t.decimal "datascale", precision: 38
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.datetime "updated_at", precision: 6
    t.decimal "dataprecision", precision: 38
    t.decimal "seqno", precision: 38
    t.string "contents", limit: 4000
  end

  create_table "itms", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 50
    t.string "name", limit: 100
    t.decimal "units_id", precision: 38
    t.string "std", limit: 50
    t.string "model", limit: 50
    t.string "material", limit: 50
    t.string "design", limit: 50
    t.decimal "weight", precision: 38, scale: 6
    t.decimal "length", precision: 38, scale: 6
    t.decimal "wide", precision: 38, scale: 6
    t.decimal "deth", precision: 38, scale: 6
    t.string "remark", limit: 200
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "datascale", precision: 38
    t.index ["code"], name: "itms_ukys1", unique: true
  end

  create_table "locas", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 40
    t.string "name", limit: 100
    t.string "abbr", limit: 50
    t.string "zip", limit: 10
    t.string "country", limit: 20
    t.string "prfct", limit: 20
    t.string "addr1", limit: 50
    t.string "addr2", limit: 50
    t.string "tel", limit: 20
    t.string "fax", limit: 20
    t.string "mail", limit: 20
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["code", "expiredate"], name: "locas_23_uk", unique: true
  end

  create_table "persons", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 10
    t.string "name", limit: 50
    t.decimal "usrgrps_id", precision: 38
    t.decimal "sects_id", precision: 38
    t.decimal "scrlvs_id", precision: 38
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "email", limit: 40
    t.index ["code"], name: "persons_16_uk", unique: true
  end

  create_table "pobjects", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.datetime "updated_at", precision: 6
    t.string "code", limit: 50
    t.string "contents", limit: 4000
    t.string "objecttype", limit: 19
    t.index ["code", "objecttype"], name: "pobjects_ukys1", unique: true
  end

  create_table "pobjgrps", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "pobjects_id", precision: 38
    t.decimal "usrgrps_id", precision: 38
    t.string "name", limit: 50
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.datetime "updated_at", precision: 6
  end

  create_table "prjnos", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "name", limit: 100
    t.string "code", limit: 50
    t.decimal "priority"
    t.decimal "prjnos_id_chil", precision: 38
  end

  create_table "reports", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "filename", limit: 50
    t.decimal "screens_id", precision: 38
    t.decimal "usrgrps_id", precision: 38
    t.date "expiredate"
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "pobjects_id_rep", precision: 38
    t.string "contents", limit: 4000
  end

  create_table "rubycodings", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "codel", limit: 100
    t.string "contents", limit: 4000
    t.decimal "pobjects_id", precision: 38
    t.string "rubycode", limit: 4000
    t.string "hikisu", limit: 400
    t.index ["codel", "expiredate"], name: "rubycodings_ukys1", unique: true
  end

  create_table "screenfields", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "screens_id", precision: 38
    t.decimal "selection", precision: 38
    t.decimal "hideflg", precision: 38
    t.decimal "seqno", precision: 38
    t.decimal "rowpos", precision: 38
    t.decimal "colpos", precision: 38
    t.decimal "width", precision: 38
    t.string "type", limit: 12
    t.decimal "dataprecision", precision: 38
    t.decimal "datascale", precision: 38
    t.decimal "indisp", precision: 38
    t.decimal "subindisp", precision: 38
    t.decimal "editable", precision: 38
    t.decimal "maxvalue", precision: 38
    t.decimal "minvalue", precision: 38
    t.decimal "edoptsize", precision: 38
    t.decimal "edoptmaxlength", precision: 38
    t.decimal "edoptrow", precision: 38
    t.decimal "edoptcols", precision: 38
    t.string "edoptvalue", limit: 800
    t.string "sumkey", limit: 1
    t.string "crtfield", limit: 100
    t.date "expiredate"
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "pobjects_id_sfd", precision: 38
    t.decimal "tblfields_id", precision: 38
    t.string "paragraph", limit: 30
    t.string "formatter", limit: 4000
    t.string "contents", limit: 4000
  end

  create_table "screens", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "strselect", limit: 4000
    t.string "strwhere", limit: 4000
    t.string "strgrouporder", limit: 4000
    t.string "ymlcode", limit: 4000
    t.string "cdrflayout", limit: 10
    t.date "expiredate"
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "pobjects_id_scr", precision: 38
    t.decimal "pobjects_id_view", precision: 38
    t.decimal "pobjects_id_sgrp", precision: 38
    t.decimal "seqno", precision: 38
    t.decimal "rows_per_page", precision: 38
    t.string "rowlist", limit: 30
    t.decimal "height", precision: 38
    t.string "form_ps", limit: 4000
    t.decimal "scrlvs_id", precision: 38
    t.string "contents", limit: 4000
    t.string "strorder", limit: 4000
    t.index ["pobjects_id_scr"], name: "screens_ukys1", unique: true
  end

  create_table "scrlvs", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 50
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.string "level1", limit: 1
    t.decimal "persons_id_upd", precision: 38
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.string "update_ip", limit: 4
    t.datetime "updated_at", precision: 6
    t.index ["code", "expiredate"], name: "scrlvs_23_uk", unique: true
  end

  create_table "sects", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "locas_id_sect", precision: 38
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
  end

  create_table "sio_r_itms", primary_key: "sio_id", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "sio_user_code", precision: 38
    t.string "sio_term_id", limit: 30
    t.decimal "sio_session_id"
    t.string "sio_command_response", limit: 1
    t.decimal "sio_session_counter", precision: 38
    t.string "sio_classname", limit: 50
    t.string "sio_viewname", limit: 30
    t.string "sio_code", limit: 30
    t.string "sio_strsql", limit: 4000
    t.decimal "sio_totalcount", precision: 38
    t.decimal "sio_recordcount", precision: 38
    t.decimal "sio_start_record", precision: 38
    t.decimal "sio_end_record", precision: 38
    t.string "sio_sord", limit: 256
    t.string "sio_search", limit: 10
    t.string "sio_sidx", limit: 256
    t.decimal "person_id_upd", precision: 22
    t.string "person_code_upd", limit: 50
    t.string "person_name_upd", limit: 100
    t.string "itm_code", limit: 50
    t.string "itm_std", limit: 50
    t.date "itm_expiredate"
    t.string "itm_model", limit: 50
    t.datetime "itm_updated_at", precision: 6
    t.decimal "itm_wide", precision: 22, scale: 6
    t.string "itm_name", limit: 100
    t.string "itm_remark", limit: 200
    t.decimal "itm_deth", precision: 22, scale: 6
    t.datetime "itm_created_at", precision: 6
    t.string "itm_update_ip", limit: 40
    t.decimal "itm_length", precision: 22, scale: 6
    t.decimal "itm_weight", precision: 22, scale: 6
    t.string "itm_design", limit: 50
    t.decimal "itm_datascale", precision: 22
    t.string "itm_material", limit: 50
    t.decimal "id", precision: 22
    t.decimal "itm_id", precision: 22
    t.decimal "itm_unit_id", precision: 22
    t.string "unit_contents", limit: 4000
    t.decimal "unit_id", precision: 22
    t.string "unit_remark", limit: 200
    t.string "unit_code", limit: 50
    t.string "unit_name", limit: 100
    t.decimal "itm_person_id_upd", precision: 22
    t.string "sio_errline", limit: 4000
    t.string "sio_org_tblname", limit: 30
    t.decimal "sio_org_tblid", precision: 38
    t.date "sio_add_time"
    t.date "sio_replay_time"
    t.string "sio_result_f", limit: 1
    t.string "sio_message_code", limit: 10
    t.string "sio_message_contents", limit: 4000
    t.string "sio_chk_done", limit: 1
  end

  create_table "sio_r_units", primary_key: "sio_id", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "sio_user_code", precision: 38
    t.string "sio_term_id", limit: 30
    t.decimal "sio_session_id"
    t.string "sio_command_response", limit: 1
    t.decimal "sio_session_counter", precision: 38
    t.string "sio_classname", limit: 50
    t.string "sio_viewname", limit: 30
    t.string "sio_code", limit: 30
    t.string "sio_strsql", limit: 4000
    t.decimal "sio_totalcount", precision: 38
    t.decimal "sio_recordcount", precision: 38
    t.decimal "sio_start_record", precision: 38
    t.decimal "sio_end_record", precision: 38
    t.string "sio_sord", limit: 256
    t.string "sio_search", limit: 10
    t.string "sio_sidx", limit: 256
    t.decimal "id", precision: 22
    t.decimal "unit_id", precision: 22
    t.string "unit_remark", limit: 4000
    t.date "unit_expiredate"
    t.string "unit_update_ip", limit: 40
    t.datetime "unit_created_at", precision: 6
    t.datetime "unit_updated_at", precision: 6
    t.decimal "unit_person_id_upd", precision: 22
    t.decimal "person_id_upd", precision: 22
    t.string "person_code_upd", limit: 50
    t.string "person_name_upd", limit: 100
    t.string "unit_code", limit: 50
    t.string "unit_name", limit: 100
    t.string "unit_contents", limit: 4000
    t.string "sio_errline", limit: 4000
    t.string "sio_org_tblname", limit: 30
    t.decimal "sio_org_tblid", precision: 38
    t.date "sio_add_time"
    t.date "sio_replay_time"
    t.string "sio_result_f", limit: 1
    t.string "sio_message_code", limit: 10
    t.string "sio_message_contents", limit: 4000
    t.string "sio_chk_done", limit: 1
  end

  create_table "tblfields", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "blktbs_id", precision: 38
    t.decimal "fieldcodes_id", precision: 38
    t.date "expiredate"
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "seqno", precision: 38
    t.string "contents", limit: 4000
    t.string "viewflmk", limit: 4000
    t.index ["blktbs_id", "fieldcodes_id"], name: "tblfields_ukys10", unique: true
  end

  create_table "units", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 50
    t.string "name", limit: 100
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.date "expiredate"
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "contents", limit: 4000
  end

  create_table "uploads", force: :cascade do |t|
    t.string "title"
    t.string "contents"
    t.string "result"
    t.string "persons_id_upd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usebuttons", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "buttons_id", precision: 38
    t.date "expiredate"
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "screens_id_ub", precision: 38
  end

  create_table "userprocs", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "session_counter", precision: 38
    t.string "sio_code", limit: 30
    t.string "status", limit: 256
    t.decimal "cnt", precision: 38
    t.decimal "cnt_out", precision: 38
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.datetime "updated_at", precision: 6
    t.index ["session_counter", "sio_code"], name: "userprocs_uk1", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "usrgrps", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 10
    t.string "name", limit: 50
    t.string "email", limit: 50
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["code", "expiredate"], name: "usrgrps_16_uk", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blktbs", "persons", column: "persons_id_upd", name: "blktb_persons_id_upd"
  add_foreign_key "blkukys", "persons", column: "persons_id_upd", name: "blkuky_persons_id_upd"
  add_foreign_key "blkukys", "tblfields", column: "tblfields_id", name: "blkuky_tblfields_id"
  add_foreign_key "buttons", "persons", column: "persons_id_upd", name: "button_persons_id_upd"
  add_foreign_key "chilscreens", "persons", column: "persons_id_upd", name: "chilscreen_persons_id_upd"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id", name: "chilscreen_screenfields_id"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id_ch", name: "chilscreen_screenfields_id_ch"
  add_foreign_key "fieldcodes", "persons", column: "persons_id_upd", name: "fieldcode_persons_id_upd"
  add_foreign_key "itms", "persons", column: "persons_id_upd", name: "itm_persons_id_upd"
  add_foreign_key "itms", "units", column: "units_id", name: "itm_units_id"
  add_foreign_key "persons", "persons", column: "persons_id_upd", name: "persons_persons_id_upd"
  add_foreign_key "persons", "scrlvs", column: "scrlvs_id", name: "persons_scrlvs_id"
  add_foreign_key "persons", "sects", column: "sects_id", name: "persons_sects_id"
  add_foreign_key "persons", "usrgrps", column: "usrgrps_id", name: "persons_usrgrps_id"
  add_foreign_key "pobjects", "persons", column: "persons_id_upd", name: "pobject_persons_id_upd"
  add_foreign_key "pobjgrps", "persons", column: "persons_id_upd", name: "pobjgrp_persons_id_upd"
  add_foreign_key "pobjgrps", "usrgrps", column: "usrgrps_id", name: "pobjgrp_usrgrps_id"
  add_foreign_key "prjnos", "persons", column: "persons_id_upd", name: "prjno_persons_id_upd"
  add_foreign_key "prjnos", "prjnos", column: "prjnos_id_chil", name: "prjno_prjnos_id_chil"
  add_foreign_key "reports", "persons", column: "persons_id_upd", name: "report_persons_id_upd"
  add_foreign_key "reports", "usrgrps", column: "usrgrps_id", name: "report_usrgrps_id"
  add_foreign_key "rubycodings", "persons", column: "persons_id_upd", name: "rubycoding_persons_id_upd"
  add_foreign_key "screenfields", "persons", column: "persons_id_upd", name: "screenfield_persons_id_upd"
  add_foreign_key "screenfields", "tblfields", column: "tblfields_id", name: "screenfield_tblfields_id"
  add_foreign_key "screens", "persons", column: "persons_id_upd", name: "screen_persons_id_upd"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_scr", name: "screen_pobjects_id_scr"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_sgrp", name: "screen_pobjects_id_sgrp"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_view", name: "screen_pobjects_id_view"
  add_foreign_key "screens", "scrlvs", column: "scrlvs_id", name: "screen_scrlvs_id"
  add_foreign_key "scrlvs", "persons", column: "persons_id_upd", name: "scrlvs_persons_id_upd"
  add_foreign_key "sects", "locas", column: "locas_id_sect", name: "sects_locas_id_sect"
  add_foreign_key "tblfields", "blktbs", column: "blktbs_id", name: "tblfield_blktbs_id"
  add_foreign_key "tblfields", "fieldcodes", column: "fieldcodes_id", name: "tblfield_fieldcodes_id"
  add_foreign_key "tblfields", "persons", column: "persons_id_upd", name: "tblfield_persons_id_upd"
  add_foreign_key "usebuttons", "buttons", column: "buttons_id", name: "usebutton_buttons_id"
  add_foreign_key "usebuttons", "persons", column: "persons_id_upd", name: "usebutton_persons_id_upd"
  add_foreign_key "userprocs", "persons", column: "persons_id_upd", name: "userprocs_persons_id_upd"
end
