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

ActiveRecord::Schema.define(version: 2019_01_02_124334) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "persons", id: :decimal, precision: 38, force: :cascade do |t|
    t.string "code", limit: 10
    t.string "name", limit: 50
    t.decimal "usrgrps_id", precision: 38
    t.decimal "sects_id", precision: 38
    t.decimal "scrlvs_id", precision: 38
    t.string "email", limit: 50
    t.string "contents", limit: 4000
    t.string "remark", limit: 4000
    t.date "expiredate"
    t.decimal "persons_id_upd", precision: 38
    t.string "update_ip", limit: 40
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
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
    t.decimal "rows_per_page", precision: 38
    t.string "rowlist", limit: 30
    t.decimal "height", precision: 38
    t.string "form_ps", limit: 4000
    t.string "grpcodename", limit: 50
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
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirm_success_url"
    t.string "session"
    t.text "create_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "display_name"
    t.string "last_name"
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

  add_foreign_key "blktbs", "persons", column: "persons_id_upd", name: "blktb_persons_id_upd"
  add_foreign_key "blktbs", "pobjects", column: "pobjects_id_tbl", name: "blktb_pobjects_id_tbl"
  add_foreign_key "blkukys", "persons", column: "persons_id_upd", name: "blkuky_persons_id_upd"
  add_foreign_key "blkukys", "tblfields", column: "tblfields_id", name: "blkuky_tblfields_id"
  add_foreign_key "buttons", "persons", column: "persons_id_upd", name: "button_persons_id_upd"
  add_foreign_key "chilscreens", "persons", column: "persons_id_upd", name: "chilscreen_persons_id_upd"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id", name: "chilscreen_screenfields_id"
  add_foreign_key "chilscreens", "screenfields", column: "screenfields_id_ch", name: "chilscreen_screenfields_id_ch"
  add_foreign_key "fieldcodes", "persons", column: "persons_id_upd", name: "fieldcode_persons_id_upd"
  add_foreign_key "fieldcodes", "pobjects", column: "pobjects_id_fld", name: "fieldcode_pobjects_id_fld"
  add_foreign_key "locas", "persons", column: "persons_id_upd", name: "locas_persons_id_upd"
  add_foreign_key "notes", "users"
  add_foreign_key "persons", "persons", column: "persons_id_upd", name: "persons_persons_id_upd"
  add_foreign_key "persons", "scrlvs", column: "scrlvs_id", name: "persons_scrlvs_id"
  add_foreign_key "persons", "sects", column: "sects_id", name: "persons_sects_id"
  add_foreign_key "persons", "usrgrps", column: "usrgrps_id", name: "persons_usrgrps_id"
  add_foreign_key "pobjects", "persons", column: "persons_id_upd", name: "pobject_persons_id_upd"
  add_foreign_key "pobjgrps", "persons", column: "persons_id_upd", name: "pobjgrp_persons_id_upd"
  add_foreign_key "pobjgrps", "pobjects", column: "pobjects_id", name: "pobjgrp_pobjects_id"
  add_foreign_key "pobjgrps", "usrgrps", column: "usrgrps_id", name: "pobjgrp_usrgrps_id"
  add_foreign_key "prjnos", "persons", column: "persons_id_upd", name: "prjno_persons_id_upd"
  add_foreign_key "prjnos", "prjnos", column: "prjnos_id_chil", name: "prjno_prjnos_id_chil"
  add_foreign_key "reports", "persons", column: "persons_id_upd", name: "report_persons_id_upd"
  add_foreign_key "reports", "pobjects", column: "pobjects_id_rep", name: "report_pobjects_id_rep"
  add_foreign_key "reports", "screens", column: "screens_id", name: "reports_screens_id_fkey", on_delete: :cascade
  add_foreign_key "reports", "screens", column: "screens_id", name: "reports_screens_id_fkey1", on_delete: :cascade
  add_foreign_key "reports", "usrgrps", column: "usrgrps_id", name: "report_usrgrps_id"
  add_foreign_key "rubycodings", "persons", column: "persons_id_upd", name: "rubycoding_persons_id_upd"
  add_foreign_key "rubycodings", "pobjects", column: "pobjects_id", name: "rubycoding_pobjects_id"
  add_foreign_key "screenfields", "persons", column: "persons_id_upd", name: "screenfield_persons_id_upd"
  add_foreign_key "screenfields", "pobjects", column: "pobjects_id_sfd", name: "screenfield_pobjects_id_sfd"
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfields_screens_id_fkey", on_delete: :cascade
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfields_screens_id_fkey1", on_delete: :cascade
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfields_screens_id_fkey2", on_delete: :cascade
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfields_screens_id_fkey3", on_delete: :cascade
  add_foreign_key "screenfields", "screens", column: "screens_id", name: "screenfields_screens_id_fkey4", on_delete: :cascade
  add_foreign_key "screenfields", "tblfields", column: "tblfields_id", name: "screenfield_tblfields_id"
  add_foreign_key "screens", "persons", column: "persons_id_upd", name: "screen_persons_id_upd"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_scr", name: "screen_pobjects_id_scr"
  add_foreign_key "screens", "pobjects", column: "pobjects_id_view", name: "screen_pobjects_id_view"
  add_foreign_key "screens", "scrlvs", column: "scrlvs_id", name: "screen_scrlvs_id"
  add_foreign_key "sects", "locas", column: "locas_id_sect", name: "sects_locas_id_sect"
  add_foreign_key "sects", "persons", column: "persons_id_upd", name: "sects_persons_id_upd"
  add_foreign_key "tblfields", "blktbs", column: "blktbs_id", name: "tblfield_blktbs_id"
  add_foreign_key "tblfields", "fieldcodes", column: "fieldcodes_id", name: "tblfield_fieldcodes_id"
  add_foreign_key "tblfields", "persons", column: "persons_id_upd", name: "tblfield_persons_id_upd"
  add_foreign_key "tblinkflds", "persons", column: "persons_id_upd", name: "tblinkfld_persons_id_upd"
  add_foreign_key "tblinkflds", "tblfields", column: "tblfields_id", name: "tblinkfld_tblfields_id"
  add_foreign_key "tblinkflds", "tblinks", column: "tblinks_id", name: "tblinkfld_tblinks_id"
  add_foreign_key "tblinks", "blktbs", column: "blktbs_id_dest", name: "tblink_blktbs_id_dest"
  add_foreign_key "tblinks", "persons", column: "persons_id_upd", name: "tblink_persons_id_upd"
  add_foreign_key "tblinks", "screens", column: "screens_id_src", name: "tblinks_screens_id_src_fkey", on_delete: :cascade
  add_foreign_key "usebuttons", "buttons", column: "buttons_id", name: "usebutton_buttons_id"
  add_foreign_key "usebuttons", "persons", column: "persons_id_upd", name: "usebutton_persons_id_upd"
  add_foreign_key "usebuttons", "screens", column: "screens_id_ub", name: "usebuttons_screens_id_ub_fkey", on_delete: :cascade
  add_foreign_key "usebuttons", "screens", column: "screens_id_ub", name: "usebuttons_screens_id_ub_fkey1", on_delete: :cascade
  add_foreign_key "usebuttons", "screens", column: "screens_id_ub", name: "usebuttons_screens_id_ub_fkey2", on_delete: :cascade
  add_foreign_key "userprocs", "persons", column: "persons_id_upd", name: "userprocs_persons_id_upd"
end
