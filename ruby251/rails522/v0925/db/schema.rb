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

  create_table "boxes", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "persons_id_upd", precision: 38
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "update_ip", limit: 40
    t.string "boxtype", limit: 20
    t.string "contents", limit: 4000
    t.decimal "depth", precision: 7, scale: 2
    t.date "expiredate"
    t.decimal "height", precision: 7, scale: 2
    t.decimal "outdepth", precision: 7, scale: 2
    t.decimal "outheight", precision: 7, scale: 2
    t.decimal "outwide", precision: 7, scale: 2
    t.string "remark", limit: 4000
    t.decimal "units_id_box", precision: 38
    t.decimal "units_id_outbox", precision: 38
    t.decimal "wide", precision: 7, scale: 2
    t.string "code", limit: 50
    t.string "name", limit: 100
    t.index ["code"], name: "boxes_ukys10", unique: true
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

  create_table "chrgs", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "contents", limit: 4000
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.decimal "persons_id_chrg", precision: 38
    t.decimal "persons_id_upd", precision: 38
    t.string "remark", limit: 4000
    t.string "update_ip", limit: 40
    t.datetime "updated_at", precision: 6
  end

  create_table "crrs", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "contents", limit: 4000
    t.decimal "amtdecimal", precision: 38
    t.string "code", limit: 50
    t.datetime "created_at", precision: 6
    t.date "expiredate"
    t.string "name", limit: 100
    t.decimal "persons_id_upd", precision: 38
    t.decimal "pricedecimal", precision: 38
    t.string "remark", limit: 100
    t.string "update_ip", limit: 40
    t.datetime "updated_at", precision: 6
    t.index ["code", "expiredate"], name: "crrs_uky1", unique: true
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
    t.decimal "weight", precision: 7, scale: 2
    t.decimal "length", precision: 38, scale: 6
    t.decimal "wide", precision: 7, scale: 2
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

  create_table "nditms", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "opeitms_id", precision: 38
    t.decimal "itms_id_nditm", precision: 38
    t.decimal "locas_id_nditm", precision: 38
    t.decimal "processseq_nditm", precision: 38
    t.decimal "parenum", precision: 22, scale: 6
    t.decimal "chilnum", precision: 22, scale: 6
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "consumtype", limit: 3
    t.decimal "consumunitqty", precision: 22, scale: 6
    t.string "consumauto", limit: 1
    t.string "contents", limit: 4000
    t.string "byproduct", limit: 1
    t.decimal "consumminqty", precision: 22, scale: 6
    t.decimal "consumchgoverqty", precision: 22, scale: 6
  end

  create_table "opeitms", id: :decimal, precision: 38, force: :cascade do |t|
    t.decimal "processseq", precision: 38
    t.decimal "priority", precision: 38
    t.decimal "locas_id", precision: 38
    t.decimal "itms_id", precision: 38
    t.decimal "packqty", precision: 18, scale: 2
    t.decimal "minqty", precision: 38, scale: 6
    t.decimal "duration", precision: 38, scale: 2
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "remark", limit: 4000
    t.string "operation", limit: 40
    t.decimal "maxqty", precision: 38, scale: 4
    t.decimal "opt_fixoterm", precision: 5, scale: 2
    t.string "autocreate_ord", limit: 1
    t.decimal "safestkqty", precision: 38
    t.decimal "units_id_case", precision: 38
    t.string "autocreate_act", limit: 1
    t.string "autocreate_inst", limit: 1
    t.string "contents", limit: 4000
    t.string "chkord", limit: 1
    t.decimal "chkord_prc", precision: 3
    t.string "shuffle_flg", limit: 1
    t.string "shuffle_loca", limit: 1
    t.decimal "esttosch", precision: 38
    t.string "stktaking_f", limit: 1
    t.string "prdpurshp", limit: 5
    t.string "mold", limit: 1
    t.string "rule_price", limit: 1
    t.string "chkinst", limit: 1
    t.decimal "boxes_id", precision: 38
    t.string "opt_fix_flg", limit: 1
    t.decimal "prjalloc_flg", precision: 38
    t.string "packno_flg", limit: 1
    t.string "units_lttime", limit: 4
    t.decimal "shelfnos_id", precision: 38
    t.decimal "autoord_p", precision: 3
    t.decimal "units_id_prdpurshp", precision: 38
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
    t.index ["email"], name: "persons_uky1", unique: true
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
    t.index ["usrgrps_id", "name", "expiredate"], name: "pobjgrps_uky1", unique: true
  end

  create_table "prdords", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "confirm", limit: 1
    t.decimal "locas_id_to", precision: 38
    t.datetime "isudate", precision: 6
    t.decimal "opeitms_id_prd", precision: 22
    t.datetime "starttime", precision: 6
    t.datetime "duedate", precision: 6
    t.decimal "qty", precision: 18, scale: 4
    t.decimal "chrgs_id", precision: 38
    t.decimal "processseq_pare", precision: 38
    t.string "sno", limit: 40
    t.string "gno", limit: 40
    t.decimal "prjnos_id", precision: 38
    t.string "consumtype", limit: 3
    t.string "autocreate_inst", limit: 1
    t.decimal "autoinst_p", precision: 3
    t.string "autocreate_act", limit: 1
    t.decimal "autoact_p", precision: 3
    t.decimal "opt_fixoterm", precision: 5, scale: 2
    t.date "expiredate"
    t.string "remark", limit: 4000
    t.datetime "toduedate", precision: 6
    t.decimal "persons_id_upd", precision: 38
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "update_ip", limit: 40
    t.decimal "qty_case", precision: 38
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

  create_table "processcontrols", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "tblname", limit: 30
    t.decimal "seqno", precision: 38
    t.string "destblname", limit: 30
    t.string "segment", limit: 10
    t.string "rubycode", limit: 4000
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.decimal "persons_id_upd", precision: 38
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.date "expiredate"
  end

  create_table "processreqs", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "tblname", limit: 30
    t.decimal "tblid", precision: 38
    t.string "result_f", limit: 1
    t.string "update_ip", limit: 40
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "persons_id_upd", precision: 38
    t.string "paretblname", limit: 30
    t.decimal "paretblid", precision: 38
    t.string "reqparams", limit: 4000
  end

  create_table "purords", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "sno", limit: 40
    t.decimal "qty", precision: 18, scale: 4
    t.datetime "duedate", precision: 6
    t.datetime "isudate", precision: 6
    t.string "remark", limit: 4000
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "amt", precision: 18, scale: 4
    t.datetime "toduedate", precision: 6
    t.decimal "persons_id_upd", precision: 38
    t.date "expiredate"
    t.decimal "price", precision: 38, scale: 4
    t.decimal "qty_case", precision: 38
    t.string "confirm", limit: 1
    t.decimal "opt_fixoterm", precision: 5, scale: 2
    t.decimal "locas_id_to", precision: 38
    t.decimal "processseq_pare", precision: 38
    t.decimal "prjnos_id", precision: 38
    t.string "contract_price", limit: 1
    t.decimal "chrgs_id", precision: 38
    t.decimal "tax", precision: 38, scale: 4
    t.string "gno", limit: 40
    t.string "itm_code_client", limit: 50
    t.datetime "starttime", precision: 6
    t.string "consumtype", limit: 3
    t.string "autocreate_inst", limit: 1
    t.string "consumauto", limit: 1
    t.decimal "autoinst_p", precision: 3
    t.decimal "autoact_p", precision: 3
    t.decimal "opeitms_id_pur", precision: 22
    t.string "autocreate_act", limit: 1
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
    t.string "subindisp", limit: 100
    t.index ["paragraph", "id"], name: "screenfields_uky2", unique: true
    t.index ["screens_id", "pobjects_id_sfd"], name: "screenfields_uky1", unique: true
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
    t.decimal "width", precision: 38
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

  create_table "shelfnos", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "code", limit: 50
    t.decimal "locas_id_shelfno", precision: 38
    t.string "name", limit: 100
    t.string "update_ip", limit: 40
    t.index ["locas_id_shelfno", "code"], name: "shelfnos_ukys10", unique: true
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

  create_table "tblinkflds", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "command_c", limit: 4000
    t.decimal "tblinks_id", precision: 38
    t.decimal "tblfields_id", precision: 38
    t.decimal "seqno", precision: 38
    t.string "contents", limit: 4000
    t.string "rubycode", limit: 4000
    t.index ["tblinks_id", "tblfields_id"], name: "tblinkflds_ukys10", unique: true
  end

  create_table "tblinks", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.decimal "blktbs_id_dest", precision: 38
    t.decimal "screens_id_src", precision: 38
    t.decimal "seqno", precision: 38
    t.string "beforeafter", limit: 15
    t.string "contents", limit: 4000
    t.string "hikisu", limit: 400
    t.string "codel", limit: 50
    t.index ["screens_id_src", "blktbs_id_dest", "beforeafter", "seqno"], name: "tblinks_ukys1", unique: true
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
  add_foreign_key "boxes", "persons", column: "persons_id_upd", name: "boxe_persons_id_upd"
  add_foreign_key "boxes", "units", column: "units_id_box", name: "boxe_units_id_box"
  add_foreign_key "boxes", "units", column: "units_id_outbox", name: "boxe_units_id_outbox"
  add_foreign_key "buttons", "persons", column: "persons_id_upd", name: "button_persons_id_upd"
  add_foreign_key "chilscreens", "persons", column: "persons_id_upd", name: "chilscreen_persons_id_upd"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id", name: "chilscreen_screenfields_id"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id_ch", name: "chilscreen_screenfields_id_ch"
  add_foreign_key "chrgs", "persons", column: "persons_id_chrg", name: "chrg_persons_id_chrg"
  add_foreign_key "chrgs", "persons", column: "persons_id_upd", name: "chrg_persons_id_upd"
  add_foreign_key "crrs", "persons", column: "persons_id_upd", name: "crr_persons_id_upd"
  add_foreign_key "fieldcodes", "persons", column: "persons_id_upd", name: "fieldcode_persons_id_upd"
  add_foreign_key "itms", "persons", column: "persons_id_upd", name: "itm_persons_id_upd"
  add_foreign_key "itms", "units", column: "units_id", name: "itm_units_id"
  add_foreign_key "nditms", "itms", column: "itms_id_nditm", name: "nditm_itms_id_nditm"
  add_foreign_key "nditms", "locas", column: "locas_id_nditm", name: "nditm_locas_id_nditm"
  add_foreign_key "nditms", "opeitms", column: "opeitms_id", name: "nditm_opeitms_id"
  add_foreign_key "nditms", "persons", column: "persons_id_upd", name: "nditm_persons_id_upd"
  add_foreign_key "opeitms", "boxes", column: "boxes_id", name: "opeitm_boxes_id"
  add_foreign_key "opeitms", "itms", column: "itms_id", name: "opeitm_itms_id"
  add_foreign_key "opeitms", "locas", column: "locas_id", name: "opeitm_locas_id"
  add_foreign_key "opeitms", "persons", column: "persons_id_upd", name: "opeitm_persons_id_upd"
  add_foreign_key "opeitms", "shelfnos", column: "shelfnos_id", name: "opeitm_shelfnos_id"
  add_foreign_key "opeitms", "units", column: "units_id_case", name: "opeitm_units_id_case"
  add_foreign_key "opeitms", "units", column: "units_id_prdpurshp", name: "opeitm_units_id_prdpurshp"
  add_foreign_key "persons", "persons", column: "persons_id_upd", name: "persons_persons_id_upd"
  add_foreign_key "persons", "scrlvs", column: "scrlvs_id", name: "persons_scrlvs_id"
  add_foreign_key "persons", "sects", column: "sects_id", name: "persons_sects_id"
  add_foreign_key "persons", "usrgrps", column: "usrgrps_id", name: "persons_usrgrps_id"
  add_foreign_key "pobjects", "persons", column: "persons_id_upd", name: "pobject_persons_id_upd"
  add_foreign_key "pobjgrps", "persons", column: "persons_id_upd", name: "pobjgrp_persons_id_upd"
  add_foreign_key "pobjgrps", "usrgrps", column: "usrgrps_id", name: "pobjgrp_usrgrps_id"
  add_foreign_key "prdords", "chrgs", column: "chrgs_id", name: "prdord_chrgs_id"
  add_foreign_key "prdords", "locas", column: "locas_id_to", name: "prdord_locas_id_to"
  add_foreign_key "prdords", "opeitms", column: "opeitms_id_prd", name: "prdord_opeitms_id_prd"
  add_foreign_key "prdords", "persons", column: "persons_id_upd", name: "prdord_persons_id_upd"
  add_foreign_key "prdords", "prjnos", column: "prjnos_id", name: "prdord_prjnos_id"
  add_foreign_key "prjnos", "persons", column: "persons_id_upd", name: "prjno_persons_id_upd"
  add_foreign_key "prjnos", "prjnos", column: "prjnos_id_chil", name: "prjno_prjnos_id_chil"
  add_foreign_key "processcontrols", "persons", column: "persons_id_upd", name: "processcontrol_persons_id_upd"
  add_foreign_key "processreqs", "persons", column: "persons_id_upd", name: "processreq_persons_id_upd"
  add_foreign_key "purords", "chrgs", column: "chrgs_id", name: "purord_chrgs_id"
  add_foreign_key "purords", "locas", column: "locas_id_to", name: "purord_locas_id_to"
  add_foreign_key "purords", "opeitms", column: "opeitms_id_pur", name: "purord_opeitms_id_pur"
  add_foreign_key "purords", "persons", column: "persons_id_upd", name: "purord_persons_id_upd"
  add_foreign_key "purords", "prjnos", column: "prjnos_id", name: "purord_prjnos_id"
  add_foreign_key "reports", "persons", column: "persons_id_upd", name: "report_persons_id_upd"
  add_foreign_key "reports", "usrgrps", column: "usrgrps_id", name: "report_usrgrps_id"
  add_foreign_key "rubycodings", "persons", column: "persons_id_upd", name: "rubycoding_persons_id_upd"
  add_foreign_key "screenfields", "persons", column: "persons_id_upd", name: "screenfield_persons_id_upd"
  add_foreign_key "screenfields", "pobjects", column: "pobjects_id_sfd", name: "screenfield_pobjects_id_sfd"
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfield_screens_id"
  add_foreign_key "screenfields", "tblfields", column: "tblfields_id", name: "screenfield_tblfields_id"
  add_foreign_key "screens", "persons", column: "persons_id_upd", name: "screen_persons_id_upd"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_scr", name: "screen_pobjects_id_scr"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_sgrp", name: "screen_pobjects_id_sgrp"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_view", name: "screen_pobjects_id_view"
  add_foreign_key "screens", "scrlvs", column: "scrlvs_id", name: "screen_scrlvs_id"
  add_foreign_key "scrlvs", "persons", column: "persons_id_upd", name: "scrlvs_persons_id_upd"
  add_foreign_key "sects", "locas", column: "locas_id_sect", name: "sects_locas_id_sect"
  add_foreign_key "shelfnos", "locas", column: "locas_id_shelfno", name: "shelfno_locas_id_shelfno"
  add_foreign_key "shelfnos", "persons", column: "persons_id_upd", name: "shelfno_persons_id_upd"
  add_foreign_key "tblfields", "blktbs", column: "blktbs_id", name: "tblfield_blktbs_id"
  add_foreign_key "tblfields", "fieldcodes", column: "fieldcodes_id", name: "tblfield_fieldcodes_id"
  add_foreign_key "tblfields", "persons", column: "persons_id_upd", name: "tblfield_persons_id_upd"
  add_foreign_key "tblinkflds", "persons", column: "persons_id_upd", name: "tblinkfld_persons_id_upd"
  add_foreign_key "tblinkflds", "tblfields", column: "tblfields_id", name: "tblinkfld_tblfields_id"
  add_foreign_key "tblinkflds", "tblinks", column: "tblinks_id", name: "tblinkfld_tblinks_id"
  add_foreign_key "tblinks", "blktbs", column: "blktbs_id_dest", name: "tblink_blktbs_id_dest"
  add_foreign_key "tblinks", "persons", column: "persons_id_upd", name: "tblink_persons_id_upd"
  add_foreign_key "usebuttons", "buttons", column: "buttons_id", name: "usebutton_buttons_id"
  add_foreign_key "usebuttons", "persons", column: "persons_id_upd", name: "usebutton_persons_id_upd"
  add_foreign_key "userprocs", "persons", column: "persons_id_upd", name: "userprocs_persons_id_upd"
end
