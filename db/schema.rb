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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120618202947) do

  create_table "aq$_internet_agent_privs", :id => false, :force => true do |t|
    t.string "agent_name",  :limit => 30, :null => false
    t.string "db_username", :limit => 30, :null => false
  end

  add_index "aq$_internet_agent_privs", ["agent_name", "db_username"], :name => "unq_pairs", :unique => true

  add_foreign_key "aq$_internet_agent_privs", "aq$_internet_agents", :column => "agent_name", :primary_key => nil, :name => "agent_must_be_created", :dependent => :delete

  create_table "aq$_internet_agents", :primary_key => "agent_name", :force => true do |t|
    t.integer "protocol",                :precision => 38, :scale => 0, :null => false
    t.string  "spare1",   :limit => 128
  end

  create_table "aq$_queue_tables", :primary_key => "objno", :force => true do |t|
    t.string  "schema",        :limit => 30,   :null => false
    t.string  "name",          :limit => 30,   :null => false
    t.decimal "udata_type",                    :null => false
    t.decimal "flags",                         :null => false
    t.decimal "sort_cols",                     :null => false
    t.string  "timezone",      :limit => 64
    t.string  "table_comment", :limit => 2000
  end

# Could not dump table "aq$_queues" because of following StandardError
#   Unknown type 'RAW' for column 'oid'

# Could not dump table "aq$_schedules" because of following StandardError
#   Unknown type 'RAW' for column 'oid'

  create_table "areas", :primary_key => "area_id", :force => true do |t|
    t.string  "nombre",             :limit => 100,                                :null => false
    t.integer "encargado",          :limit => 10,  :precision => 10, :scale => 0
    t.float   "compras_tot",        :limit => 126,                                :null => false
    t.float   "compras_ultimo_mes", :limit => 126,                                :null => false
  end

  add_foreign_key "areas", "usuarios", :column => "encargado", :name => "fkey_encargado"

  create_table "articulos", :primary_key => "articulo_id", :force => true do |t|
    t.string  "descripcion",          :limit => 200,                                                :null => false
    t.integer "stock",                :limit => 5,   :precision => 5, :scale => 0,                  :null => false
    t.float   "precio_ultima_compra", :limit => 126,                               :default => 0.0
    t.integer "punto_reorden",        :limit => 5,   :precision => 5, :scale => 0,                  :null => false
  end

# Could not dump table "def$_aqcall" because of following StandardError
#   Unknown type 'RAW' for column 'msgid'

# Could not dump table "def$_aqerror" because of following StandardError
#   Unknown type 'RAW' for column 'msgid'

# Could not dump table "def$_calldest" because of following StandardError
#   Unknown type 'RAW' for column 'catchup'

  add_foreign_key "def$_calldest", "def$_destination", :columns => ["catchup", "dblink"], :name => "def$_call_destination"

  create_table "def$_defaultdest", :primary_key => "dblink", :force => true do |t|
  end

# Could not dump table "def$_destination" because of following StandardError
#   Unknown type 'RAW' for column 'catchup'

  create_table "def$_error", :primary_key => "enq_tid", :force => true do |t|
    t.string   "origin_tran_db", :limit => 128
    t.string   "origin_enq_tid", :limit => 22
    t.string   "destination",    :limit => 128
    t.decimal  "step_no"
    t.decimal  "receiver"
    t.datetime "enq_time"
    t.decimal  "error_number"
    t.string   "error_msg",      :limit => 2000
  end

# Could not dump table "def$_lob" because of following StandardError
#   Unknown type 'RAW' for column 'id'

# Could not dump table "def$_origin" because of following StandardError
#   Unknown type 'RAW' for column 'catchup'

  create_table "def$_propagator", :primary_key => "userid", :force => true do |t|
    t.string   "username", :limit => 30, :null => false
    t.datetime "created",                :null => false
  end

  create_table "def$_pushed_transactions", :primary_key => "source_site_id", :force => true do |t|
    t.decimal "last_tran_id",                :default => 0.0
    t.string  "disabled",     :limit => 1,   :default => "F"
    t.string  "source_site",  :limit => 128
  end

  create_table "def$_temp$lob", :id => false, :force => true do |t|
    t.binary "temp$blob"
    t.text   "temp$clob"
    t.text   "temp$nclob"
  end

  create_table "entradas", :primary_key => "entrada_id", :force => true do |t|
    t.integer  "articulo_id",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "orden_compra_id",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "usuario_entrada_id", :limit => 10, :precision => 10, :scale => 0
    t.integer  "cantidad",           :limit => 5,  :precision => 5,  :scale => 0
    t.datetime "fecha"
  end

  add_foreign_key "entradas", "articulos", :primary_key => nil, :name => "fkey_art_ent"
  add_foreign_key "entradas", "ordenes", :column => "orden_compra_id", :primary_key => nil, :name => "fkey_orden_ent"
  add_foreign_key "entradas", "usuarios", :column => "usuario_entrada_id", :name => "fkey_usua_ent"

  create_table "estatus_requisiciones", :primary_key => "estatus_id", :force => true do |t|
    t.string "estatus",     :limit => 80,  :null => false
    t.string "descripcion", :limit => 200, :null => false
  end

  create_table "help", :id => false, :force => true do |t|
    t.string  "topic", :limit => 50, :null => false
    t.decimal "seq",                 :null => false
    t.string  "info",  :limit => 80
  end

  create_table "logmnr_age_spill$", :id => false, :force => true do |t|
    t.decimal "session#",                                  :null => false
    t.decimal "xidusn",                                    :null => false
    t.decimal "xidslt",                                    :null => false
    t.decimal "xidsqn",                                    :null => false
    t.integer "chunk",      :precision => 38, :scale => 0, :null => false
    t.decimal "sequence#",                                 :null => false
    t.decimal "offset"
    t.binary  "spill_data"
    t.decimal "spare1"
    t.decimal "spare2"
  end

  create_table "logmnr_attrcol$", :id => false, :force => true do |t|
    t.decimal "intcol#"
    t.string  "name",       :limit => 4000
    t.decimal "obj#",                                                      :null => false
    t.integer "logmnr_uid", :limit => 22,   :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22,   :precision => 22, :scale => 0
  end

  add_index "logmnr_attrcol$", ["logmnr_uid", "obj#", "intcol#"], :name => "logmnr_i1attrcol$"

# Could not dump table "logmnr_attribute$" because of following StandardError
#   Unknown type 'RAW' for column 'attr_toid'

  create_table "logmnr_ccol$", :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "obj#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "intcol#",                                                 :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_ccol$", ["logmnr_uid", "con#", "intcol#"], :name => "logmnr_i1ccol$"

  create_table "logmnr_cdef$", :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "cols"
    t.decimal "type#"
    t.decimal "robj#"
    t.decimal "rcon#"
    t.decimal "enabled"
    t.decimal "defer"
    t.decimal "obj#",                                                    :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_cdef$", ["logmnr_uid", "con#"], :name => "logmnr_i1cdef$"

  create_table "logmnr_col$", :id => false, :force => true do |t|
    t.integer "col#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "segcol#",     :limit => 22, :precision => 22, :scale => 0
    t.string  "name",        :limit => 30
    t.integer "type#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "length",      :limit => 22, :precision => 22, :scale => 0
    t.integer "precision#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "scale",       :limit => 22, :precision => 22, :scale => 0
    t.integer "null$",       :limit => 22, :precision => 22, :scale => 0
    t.integer "intcol#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "property",    :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetid",   :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetform", :limit => 22, :precision => 22, :scale => 0
    t.integer "spare1",      :limit => 22, :precision => 22, :scale => 0
    t.integer "spare2",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid",  :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",       :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_col$", ["logmnr_uid", "obj#", "intcol#"], :name => "logmnr_i1col$"
  add_index "logmnr_col$", ["logmnr_uid", "obj#", "name"], :name => "logmnr_i2col$"

# Could not dump table "logmnr_coltype$" because of following StandardError
#   Unknown type 'RAW' for column 'toid'

# Could not dump table "logmnr_dictionary$" because of following StandardError
#   Unknown type 'RAW' for column 'db_thread_map'

  create_table "logmnr_dictstate$", :primary_key => "logmnr_uid", :force => true do |t|
    t.decimal "start_scnbas"
    t.decimal "start_scnwrp"
    t.decimal "end_scnbas"
    t.decimal "end_scnwrp"
    t.decimal "redo_thread"
    t.decimal "rbasqn"
    t.decimal "rbablk"
    t.decimal "rbabyte"
  end

  create_table "logmnr_error$", :id => false, :force => true do |t|
    t.decimal  "session#"
    t.datetime "time_of_error"
    t.decimal  "code"
    t.string   "message",       :limit => 4000
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",        :limit => 4000
    t.string   "spare5",        :limit => 4000
  end

  create_table "logmnr_filter$", :id => false, :force => true do |t|
    t.decimal  "session#"
    t.string   "filter_type", :limit => 30
    t.decimal  "attr1"
    t.decimal  "attr2"
    t.decimal  "attr3"
    t.decimal  "attr4"
    t.decimal  "attr5"
    t.decimal  "attr6"
    t.decimal  "filter_scn"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.datetime "spare3"
  end

  create_table "logmnr_header1$", :id => false, :force => true do |t|
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnr_header2$", :id => false, :force => true do |t|
    t.integer "objv#", :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnr_icol$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "segcol#"
    t.decimal "intcol#",                                                 :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_icol$", ["logmnr_uid", "obj#", "intcol#"], :name => "logmnr_i1icol$"

  create_table "logmnr_ind$", :id => false, :force => true do |t|
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",       :limit => 22, :precision => 22, :scale => 0
    t.integer "type#",      :limit => 22, :precision => 22, :scale => 0
    t.decimal "flags"
    t.decimal "property"
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_ind$", ["logmnr_uid", "bo#"], :name => "logmnr_i2ind$"
  add_index "logmnr_ind$", ["logmnr_uid", "obj#"], :name => "logmnr_i1ind$"

  create_table "logmnr_indcompart$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "dataobj#"
    t.decimal "bo#"
    t.decimal "part#",                                                   :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_indcompart$", ["logmnr_uid", "obj#"], :name => "logmnr_i1indcompart$"

  create_table "logmnr_indpart$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "part#"
    t.decimal "ts#",                                                     :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_indpart$", ["logmnr_uid", "bo#"], :name => "logmnr_i2indpart$"
  add_index "logmnr_indpart$", ["logmnr_uid", "obj#", "bo#"], :name => "logmnr_i1indpart$"

  create_table "logmnr_indsubpart$", :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_indsubpart$", ["logmnr_uid", "obj#", "pobj#"], :name => "logmnr_i1indsubpart$"

  create_table "logmnr_lob$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "intcol#"
    t.decimal "col#"
    t.decimal "lobj#"
    t.decimal "chunk",                                                   :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_lob$", ["logmnr_uid", "obj#", "intcol#"], :name => "logmnr_i1lob$"

  create_table "logmnr_lobfrag$", :id => false, :force => true do |t|
    t.decimal "fragobj#"
    t.decimal "parentobj#"
    t.decimal "tabfragobj#"
    t.decimal "indfragobj#"
    t.decimal "frag#",                                                    :null => false
    t.integer "logmnr_uid",  :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",       :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_lobfrag$", ["logmnr_uid", "fragobj#"], :name => "logmnr_i1lobfrag$"

  create_table "logmnr_log$", :id => false, :force => true do |t|
    t.decimal  "session#",                              :null => false
    t.decimal  "thread#",                               :null => false
    t.decimal  "sequence#",                             :null => false
    t.decimal  "first_change#",                         :null => false
    t.decimal  "next_change#"
    t.datetime "first_time"
    t.datetime "next_time"
    t.string   "file_name",              :limit => 513
    t.decimal  "status"
    t.string   "info",                   :limit => 32
    t.datetime "timestamp"
    t.string   "dict_begin",             :limit => 3
    t.string   "dict_end",               :limit => 3
    t.string   "status_info",            :limit => 32
    t.decimal  "db_id",                                 :null => false
    t.decimal  "resetlogs_change#",                     :null => false
    t.decimal  "reset_timestamp",                       :null => false
    t.decimal  "prev_resetlogs_change#"
    t.decimal  "prev_reset_timestamp"
    t.decimal  "blocks"
    t.decimal  "block_size"
    t.decimal  "flags"
    t.decimal  "contents"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.decimal  "spare4"
    t.decimal  "spare5"
  end

  add_index "logmnr_log$", ["first_change#"], :name => "logmnr_log$_first_change#", :tablespace => "sysaux"
  add_index "logmnr_log$", ["flags"], :name => "logmnr_log$_flags", :tablespace => "sysaux"

# Could not dump table "logmnr_obj$" because of following StandardError
#   Unknown type 'RAW' for column 'oid$'

  create_table "logmnr_parameter$", :id => false, :force => true do |t|
    t.decimal "session#",                 :null => false
    t.string  "name",     :limit => 30,   :null => false
    t.string  "value",    :limit => 2000
    t.decimal "type"
    t.decimal "scn"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",   :limit => 2000
  end

  add_index "logmnr_parameter$", ["session#", "name"], :name => "logmnr_parameter_indx"

  create_table "logmnr_processed_log$", :id => false, :force => true do |t|
    t.decimal  "session#",                     :null => false
    t.decimal  "thread#",                      :null => false
    t.decimal  "sequence#"
    t.decimal  "first_change#"
    t.decimal  "next_change#"
    t.datetime "first_time"
    t.datetime "next_time"
    t.string   "file_name",     :limit => 513
    t.decimal  "status"
    t.string   "info",          :limit => 32
    t.datetime "timestamp"
  end

  create_table "logmnr_restart_ckpt$", :id => false, :force => true do |t|
    t.decimal "session#",    :null => false
    t.decimal "valid"
    t.decimal "ckpt_scn",    :null => false
    t.decimal "xidusn",      :null => false
    t.decimal "xidslt",      :null => false
    t.decimal "xidsqn",      :null => false
    t.decimal "session_num", :null => false
    t.decimal "serial_num",  :null => false
    t.binary  "ckpt_info"
    t.decimal "flag"
    t.decimal "offset"
    t.binary  "client_data"
    t.decimal "spare1"
    t.decimal "spare2"
  end

  create_table "logmnr_restart_ckpt_txinfo$", :id => false, :force => true do |t|
    t.decimal "session#",      :null => false
    t.decimal "xidusn",        :null => false
    t.decimal "xidslt",        :null => false
    t.decimal "xidsqn",        :null => false
    t.decimal "session_num",   :null => false
    t.decimal "serial_num",    :null => false
    t.decimal "flag"
    t.decimal "start_scn"
    t.decimal "effective_scn", :null => false
    t.decimal "offset"
    t.binary  "tx_data"
  end

  create_table "logmnr_session$", :primary_key => "session#", :force => true do |t|
    t.decimal  "client#"
    t.string   "session_name",         :limit => 128,  :null => false
    t.decimal  "db_id"
    t.decimal  "resetlogs_change#"
    t.decimal  "session_attr"
    t.string   "session_attr_verbose", :limit => 400
    t.decimal  "start_scn"
    t.decimal  "end_scn"
    t.decimal  "spill_scn"
    t.datetime "spill_time"
    t.decimal  "oldest_scn"
    t.decimal  "resume_scn"
    t.string   "global_db_name",       :limit => 128
    t.decimal  "reset_timestamp"
    t.decimal  "branch_scn"
    t.string   "version",              :limit => 64
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.decimal  "spare4"
    t.decimal  "spare5"
    t.datetime "spare6"
    t.string   "spare7",               :limit => 1000
    t.string   "spare8",               :limit => 1000
  end

  add_index "logmnr_session$", ["session_name"], :name => "logmnr_session_uk1", :unique => true

  create_table "logmnr_session_evolve$", :id => false, :force => true do |t|
    t.decimal  "branch_level"
    t.decimal  "session#",             :null => false
    t.decimal  "db_id",                :null => false
    t.decimal  "reset_scn",            :null => false
    t.decimal  "reset_timestamp",      :null => false
    t.decimal  "prev_reset_scn"
    t.decimal  "prev_reset_timestamp"
    t.decimal  "status"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.datetime "spare4"
  end

  create_table "logmnr_spill$", :id => false, :force => true do |t|
    t.decimal "session#",                                  :null => false
    t.decimal "xidusn",                                    :null => false
    t.decimal "xidslt",                                    :null => false
    t.decimal "xidsqn",                                    :null => false
    t.integer "chunk",      :precision => 38, :scale => 0, :null => false
    t.decimal "sequence#",                                 :null => false
    t.decimal "offset"
    t.binary  "spill_data"
    t.decimal "spare1"
    t.decimal "spare2"
  end

  create_table "logmnr_tab$", :id => false, :force => true do |t|
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",       :limit => 22, :precision => 22, :scale => 0
    t.integer "property",   :limit => 22, :precision => 22, :scale => 0
    t.integer "intcols",    :limit => 22, :precision => 22, :scale => 0
    t.integer "kernelcols", :limit => 22, :precision => 22, :scale => 0
    t.integer "bobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "trigflag",   :limit => 22, :precision => 22, :scale => 0
    t.integer "flags",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_tab$", ["logmnr_uid", "bobj#"], :name => "logmnr_i2tab$"
  add_index "logmnr_tab$", ["logmnr_uid", "obj#"], :name => "logmnr_i1tab$"

  create_table "logmnr_tabcompart$", :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "part#",      :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_tabcompart$", ["logmnr_uid", "bo#"], :name => "logmnr_i2tabcompart$"
  add_index "logmnr_tabcompart$", ["logmnr_uid", "obj#"], :name => "logmnr_i1tabcompart$"

  create_table "logmnr_tabpart$", :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.decimal "part#"
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_tabpart$", ["logmnr_uid", "bo#"], :name => "logmnr_i2tabpart$"
  add_index "logmnr_tabpart$", ["logmnr_uid", "obj#", "bo#"], :name => "logmnr_i1tabpart$"

  create_table "logmnr_tabsubpart$", :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_tabsubpart$", ["logmnr_uid", "obj#", "pobj#"], :name => "logmnr_i1tabsubpart$"
  add_index "logmnr_tabsubpart$", ["logmnr_uid", "pobj#"], :name => "logmnr_i2tabsubpart$"

  create_table "logmnr_ts$", :id => false, :force => true do |t|
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.string  "name",       :limit => 30
    t.integer "owner#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "blocksize",  :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_ts$", ["logmnr_uid", "ts#"], :name => "logmnr_i1ts$"

# Could not dump table "logmnr_type$" because of following StandardError
#   Unknown type 'RAW' for column 'tvoid'

  create_table "logmnr_uid$", :primary_key => "session#", :force => true do |t|
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnr_user$", :id => false, :force => true do |t|
    t.integer "user#",      :limit => 22, :precision => 22, :scale => 0
    t.string  "name",       :limit => 30,                                :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
  end

  add_index "logmnr_user$", ["logmnr_uid", "user#"], :name => "logmnr_i1user$"

  create_table "logmnrc_dbname_uid_map", :primary_key => "global_name", :force => true do |t|
    t.decimal "logmnr_uid"
    t.decimal "flags"
  end

  create_table "logmnrc_gsii", :id => false, :force => true do |t|
    t.decimal  "logmnr_uid",                    :null => false
    t.decimal  "obj#",                          :null => false
    t.decimal  "bo#",                           :null => false
    t.decimal  "indtype#",                      :null => false
    t.decimal  "drop_scn"
    t.decimal  "logmnr_spare1"
    t.decimal  "logmnr_spare2"
    t.string   "logmnr_spare3", :limit => 1000
    t.datetime "logmnr_spare4"
  end

# Could not dump table "logmnrc_gtcs" because of following StandardError
#   Unknown type 'RAW' for column 'toid'

  create_table "logmnrc_gtlo", :id => false, :force => true do |t|
    t.decimal  "logmnr_uid",                    :null => false
    t.decimal  "keyobj#",                       :null => false
    t.decimal  "lvlcnt",                        :null => false
    t.decimal  "baseobj#",                      :null => false
    t.decimal  "baseobjv#",                     :null => false
    t.decimal  "lvl1obj#"
    t.decimal  "lvl2obj#"
    t.decimal  "lvl0type#",                     :null => false
    t.decimal  "lvl1type#"
    t.decimal  "lvl2type#"
    t.decimal  "owner#"
    t.string   "ownername",     :limit => 30,   :null => false
    t.string   "lvl0name",      :limit => 30,   :null => false
    t.string   "lvl1name",      :limit => 30
    t.string   "lvl2name",      :limit => 30
    t.decimal  "intcols",                       :null => false
    t.decimal  "cols"
    t.decimal  "kernelcols"
    t.decimal  "tab_flags"
    t.decimal  "trigflag"
    t.decimal  "assoc#"
    t.decimal  "obj_flags"
    t.decimal  "ts#"
    t.string   "tsname",        :limit => 30
    t.decimal  "property"
    t.decimal  "start_scn",                     :null => false
    t.decimal  "drop_scn"
    t.decimal  "xidusn"
    t.decimal  "xidslt"
    t.decimal  "xidsqn"
    t.decimal  "flags"
    t.decimal  "logmnr_spare1"
    t.decimal  "logmnr_spare2"
    t.string   "logmnr_spare3", :limit => 1000
    t.datetime "logmnr_spare4"
    t.decimal  "logmnr_spare5"
    t.decimal  "logmnr_spare6"
    t.decimal  "logmnr_spare7"
    t.decimal  "logmnr_spare8"
    t.decimal  "logmnr_spare9"
  end

  add_index "logmnrc_gtlo", ["logmnr_uid", "baseobj#", "baseobjv#"], :name => "logmnrc_i2gtlo"
  add_index "logmnrc_gtlo", ["logmnr_uid", "drop_scn"], :name => "logmnrc_i3gtlo"

  create_table "logmnrp_ctas_part_map", :id => false, :force => true do |t|
    t.decimal "logmnr_uid",                 :null => false
    t.decimal "baseobj#",                   :null => false
    t.decimal "baseobjv#",                  :null => false
    t.decimal "keyobj#",                    :null => false
    t.decimal "part#",                      :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",     :limit => 1000
  end

  add_index "logmnrp_ctas_part_map", ["logmnr_uid", "baseobj#", "baseobjv#", "part#"], :name => "logmnrp_ctas_part_map_i", :tablespace => "sysaux"

# Could not dump table "logmnrt_mddl$" because of following StandardError
#   Unknown type 'ROWID' for column 'source_rowid'

  create_table "logstdby$apply_milestone", :id => false, :force => true do |t|
    t.decimal  "session_id",                                      :null => false
    t.decimal  "commit_scn",                                      :null => false
    t.datetime "commit_time"
    t.decimal  "synch_scn",                                       :null => false
    t.decimal  "epoch",                                           :null => false
    t.decimal  "processed_scn",                                   :null => false
    t.datetime "processed_time"
    t.decimal  "fetchlwm_scn",                   :default => 0.0, :null => false
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",         :limit => 2000
  end

  create_table "logstdby$apply_progress", :id => false, :force => true do |t|
    t.decimal  "xidusn"
    t.decimal  "xidslt"
    t.decimal  "xidsqn"
    t.decimal  "commit_scn"
    t.datetime "commit_time"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",      :limit => 2000
  end

  create_table "logstdby$events", :id => false, :force => true do |t|
    t.timestamp "event_time",  :limit => 6
    t.decimal   "current_scn"
    t.decimal   "commit_scn"
    t.decimal   "xidusn"
    t.decimal   "xidslt"
    t.decimal   "xidsqn"
    t.decimal   "errval"
    t.string    "event",       :limit => 2000
    t.text      "full_event"
    t.string    "error",       :limit => 2000
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.string    "spare3",      :limit => 2000
  end

  add_index "logstdby$events", ["event_time"], :name => "logstdby$events_ind", :tablespace => "sysaux"

  create_table "logstdby$history", :id => false, :force => true do |t|
    t.decimal  "stream_sequence#"
    t.decimal  "lmnr_sid"
    t.decimal  "dbid"
    t.decimal  "first_change#"
    t.decimal  "last_change#"
    t.decimal  "source"
    t.decimal  "status"
    t.datetime "first_time"
    t.datetime "last_time"
    t.string   "dgname"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",           :limit => 2000
  end

  create_table "logstdby$parameters", :id => false, :force => true do |t|
    t.string  "name",   :limit => 30
    t.string  "value",  :limit => 2000
    t.decimal "type"
    t.decimal "scn"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3", :limit => 2000
  end

  create_table "logstdby$plsql", :id => false, :force => true do |t|
    t.decimal "session_id"
    t.decimal "start_finish"
    t.text    "call_text"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",       :limit => 2000
  end

  create_table "logstdby$scn", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.string  "objname", :limit => 4000
    t.string  "schema",  :limit => 30
    t.string  "type",    :limit => 20
    t.decimal "scn"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",  :limit => 2000
  end

  create_table "logstdby$skip", :id => false, :force => true do |t|
    t.decimal "error"
    t.string  "statement_opt", :limit => 30
    t.string  "schema",        :limit => 30
    t.string  "name",          :limit => 30
    t.decimal "use_like"
    t.string  "esc",           :limit => 1
    t.string  "proc",          :limit => 98
    t.decimal "active"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",        :limit => 2000
  end

  create_table "logstdby$skip_support", :id => false, :force => true do |t|
    t.decimal "action",                 :null => false
    t.string  "name",   :limit => 30,   :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3", :limit => 2000
  end

  create_table "logstdby$skip_transaction", :id => false, :force => true do |t|
    t.decimal "xidusn"
    t.decimal "xidslt"
    t.decimal "xidsqn"
    t.decimal "active"
    t.decimal "commit_scn"
    t.decimal "spare2"
    t.string  "spare3",     :limit => 2000
  end

# Could not dump table "mview$_adv_ajg" because of following StandardError
#   Unknown type 'LONG RAW' for column 'ajgdes'

  add_foreign_key "mview$_adv_ajg", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_ajg_fk"

  create_table "mview$_adv_basetable", :id => false, :force => true do |t|
    t.decimal "collectionid#",               :null => false
    t.decimal "queryid#",                    :null => false
    t.string  "owner",         :limit => 30
    t.string  "table_name",    :limit => 30
    t.decimal "table_type"
  end

  add_index "mview$_adv_basetable", ["queryid#"], :name => "mview$_adv_basetable_idx_01"

  add_foreign_key "mview$_adv_basetable", "mview$_adv_workload", :column => "queryid#", :primary_key => nil, :name => "mview$_adv_basetable_fk"

# Could not dump table "mview$_adv_clique" because of following StandardError
#   Unknown type 'LONG RAW' for column 'cliquedes'

  add_foreign_key "mview$_adv_clique", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_clique_fk"

  create_table "mview$_adv_eligible", :id => false, :force => true do |t|
    t.decimal "sumobjn#",  :null => false
    t.decimal "runid#",    :null => false
    t.decimal "bytecost",  :null => false
    t.decimal "flags",     :null => false
    t.decimal "frequency", :null => false
  end

  add_foreign_key "mview$_adv_eligible", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_eligible_fk"

# Could not dump table "mview$_adv_exceptions" because of following StandardError
#   Unknown type 'ROWID' for column 'bad_rowid'

  add_foreign_key "mview$_adv_exceptions", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_exception_fk"

  create_table "mview$_adv_filter", :id => false, :force => true do |t|
    t.decimal  "filterid#",                     :null => false
    t.decimal  "subfilternum#",                 :null => false
    t.decimal  "subfiltertype",                 :null => false
    t.string   "str_value",     :limit => 1028
    t.decimal  "num_value1"
    t.decimal  "num_value2"
    t.datetime "date_value1"
    t.datetime "date_value2"
  end

  create_table "mview$_adv_filterinstance", :id => false, :force => true do |t|
    t.decimal  "runid#",                        :null => false
    t.decimal  "filterid#"
    t.decimal  "subfilternum#"
    t.decimal  "subfiltertype"
    t.string   "str_value",     :limit => 1028
    t.decimal  "num_value1"
    t.decimal  "num_value2"
    t.datetime "date_value1"
    t.datetime "date_value2"
  end

  add_foreign_key "mview$_adv_filterinstance", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_filterinstance_fk"

# Could not dump table "mview$_adv_fjg" because of following StandardError
#   Unknown type 'LONG RAW' for column 'fjgdes'

  add_foreign_key "mview$_adv_fjg", "mview$_adv_ajg", :column => "ajgid#", :primary_key => nil, :name => "mview$_adv_fjg_fk"

# Could not dump table "mview$_adv_gc" because of following StandardError
#   Unknown type 'LONG RAW' for column 'gcdes'

  add_foreign_key "mview$_adv_gc", "mview$_adv_fjg", :column => "fjgid#", :primary_key => nil, :name => "mview$_adv_gc_fk"

# Could not dump table "mview$_adv_info" because of following StandardError
#   Unknown type 'LONG RAW' for column 'info'

  add_foreign_key "mview$_adv_info", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_info_fk"

# Could not dump table "mview$_adv_journal" because of following StandardError
#   Unknown type 'LONG' for column 'text'

  add_foreign_key "mview$_adv_journal", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_journal_fk"

# Could not dump table "mview$_adv_level" because of following StandardError
#   Unknown type 'RAW' for column 'columnlist'

  add_foreign_key "mview$_adv_level", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_level_fk"

  create_table "mview$_adv_log", :primary_key => "runid#", :force => true do |t|
    t.decimal  "filterid#"
    t.datetime "run_begin"
    t.datetime "run_end"
    t.decimal  "run_type"
    t.string   "uname",      :limit => 30
    t.decimal  "status",                     :null => false
    t.string   "message",    :limit => 2000
    t.decimal  "completed"
    t.decimal  "total"
    t.string   "error_code", :limit => 20
  end

# Could not dump table "mview$_adv_output" because of following StandardError
#   Unknown type 'LONG' for column 'query_text'

  add_foreign_key "mview$_adv_output", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_output_fk"

  create_table "mview$_adv_parameters", :primary_key => "parameter_name", :force => true do |t|
    t.decimal  "parameter_type",                :null => false
    t.string   "string_value",    :limit => 30
    t.datetime "date_value"
    t.decimal  "numerical_value"
  end

# Could not dump table "mview$_adv_plan" because of following StandardError
#   Unknown type 'LONG' for column 'other'

# Could not dump table "mview$_adv_pretty" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

  create_table "mview$_adv_rollup", :id => false, :force => true do |t|
    t.decimal "runid#",    :null => false
    t.decimal "clevelid#", :null => false
    t.decimal "plevelid#", :null => false
    t.decimal "flags",     :null => false
  end

  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", :columns => ["clevelid#", "runid#"], :name => "mview$_adv_rollup_cfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_level", :columns => ["plevelid#", "runid#"], :name => "mview$_adv_rollup_pfk"
  add_foreign_key "mview$_adv_rollup", "mview$_adv_log", :column => "runid#", :primary_key => nil, :name => "mview$_adv_rollup_fk"

# Could not dump table "mview$_adv_sqldepend" because of following StandardError
#   Unknown type 'RAW' for column 'from_address'

# Could not dump table "mview$_adv_temp" because of following StandardError
#   Unknown type 'LONG' for column 'text'

# Could not dump table "mview$_adv_workload" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

# Could not dump table "ol$" because of following StandardError
#   Unknown type 'LONG' for column 'sql_text'

  create_table "ol$hints", :temporary => true, :id => false, :force => true do |t|
    t.string  "ol_name",         :limit => 30
    t.decimal "hint#"
    t.string  "category",        :limit => 30
    t.decimal "hint_type"
    t.string  "hint_text",       :limit => 512
    t.decimal "stage#"
    t.decimal "node#"
    t.string  "table_name",      :limit => 30
    t.decimal "table_tin"
    t.decimal "table_pos"
    t.decimal "ref_id"
    t.string  "user_table_name", :limit => 64
    t.float   "cost",            :limit => 126
    t.float   "cardinality",     :limit => 126
    t.float   "bytes",           :limit => 126
    t.decimal "hint_textoff"
    t.decimal "hint_textlen"
    t.string  "join_pred",       :limit => 2000
    t.decimal "spare1"
    t.decimal "spare2"
    t.text    "hint_string"
  end

  add_index "ol$hints", ["ol_name", "hint#"], :name => "ol$hnt_num", :unique => true

  create_table "ol$nodes", :temporary => true, :id => false, :force => true do |t|
    t.string  "ol_name",      :limit => 30
    t.string  "category",     :limit => 30
    t.decimal "node_id"
    t.decimal "parent_id"
    t.decimal "node_type"
    t.decimal "node_textlen"
    t.decimal "node_textoff"
    t.string  "node_name",    :limit => 64
  end

  create_table "ordenes", :primary_key => "orden_id", :force => true do |t|
    t.integer  "requisicion_id",          :limit => 10,  :precision => 10, :scale => 0
    t.datetime "fecha"
    t.integer  "peticion_usuario_id",     :limit => 10,  :precision => 10, :scale => 0
    t.integer  "autorizacion_usuario_id", :limit => 10,  :precision => 10, :scale => 0
    t.integer  "proveedor_id",            :limit => 10,  :precision => 10, :scale => 0
    t.float    "total",                   :limit => 126,                                :null => false
    t.string   "estatus",                 :limit => 5,                                  :null => false
  end

  add_foreign_key "ordenes", "proveedores", :column => "proveedor_id", :primary_key => nil, :name => "fkey_prov_ord"
  add_foreign_key "ordenes", "usuarios", :column => "autorizacion_usuario_id", :name => "fkey_usuario_ord"
  add_foreign_key "ordenes", "usuarios", :column => "peticion_usuario_id", :name => "fkey_usuarios_ord"

  create_table "ordenes_articulos", :id => false, :force => true do |t|
    t.integer "orden_id",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer "articulo_id", :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer "cantidad",    :limit => 5,   :precision => 5,  :scale => 0, :null => false
    t.float   "precio",      :limit => 126,                                :null => false
    t.float   "sub_total",   :limit => 126,                                :null => false
  end

  add_foreign_key "ordenes_articulos", "articulos", :primary_key => nil, :name => "fkey_arts_ord"
  add_foreign_key "ordenes_articulos", "ordenes", :column => "orden_id", :primary_key => nil, :name => "fkey_requi_ord"

  create_table "proveedores", :primary_key => "proveedor_id", :force => true do |t|
    t.string "nombre",            :limit => 100, :null => false
    t.string "contacto",          :limit => 100
    t.string "direccion",         :limit => 100, :null => false
    t.string "telefono",          :limit => 40,  :null => false
    t.float  "compra_total",      :limit => 126
    t.float  "compra_mes_pasado", :limit => 126
  end

  create_table "repcat$_audit_attribute", :primary_key => "attribute", :force => true do |t|
    t.integer "data_type_id",               :precision => 38, :scale => 0, :null => false
    t.integer "data_length",                :precision => 38, :scale => 0
    t.string  "source",       :limit => 92,                                :null => false
  end

  create_table "repcat$_audit_column", :id => false, :force => true do |t|
    t.string  "sname",                 :limit => 30,                                :null => false
    t.string  "oname",                 :limit => 30,                                :null => false
    t.string  "column_name",           :limit => 30,                                :null => false
    t.string  "base_sname",            :limit => 30,                                :null => false
    t.string  "base_oname",            :limit => 30,                                :null => false
    t.integer "base_conflict_type_id",               :precision => 38, :scale => 0, :null => false
    t.string  "base_reference_name",   :limit => 30,                                :null => false
    t.string  "attribute",             :limit => 30,                                :null => false
  end

  add_foreign_key "repcat$_audit_column", "repcat$_audit_attribute", :column => "attribute", :primary_key => nil, :name => "repcat$_audit_column_f1"
  add_foreign_key "repcat$_audit_column", "repcat$_conflict", :columns => ["base_conflict_type_id", "base_oname", "base_reference_name", "base_sname"], :name => "repcat$_audit_column_f2"

  create_table "repcat$_column_group", :id => false, :force => true do |t|
    t.string "sname",         :limit => 30, :null => false
    t.string "oname",         :limit => 30, :null => false
    t.string "group_name",    :limit => 30, :null => false
    t.string "group_comment", :limit => 80
  end

  create_table "repcat$_conflict", :id => false, :force => true do |t|
    t.string  "sname",            :limit => 30,                                :null => false
    t.string  "oname",            :limit => 30,                                :null => false
    t.integer "conflict_type_id",               :precision => 38, :scale => 0, :null => false
    t.string  "reference_name",   :limit => 30,                                :null => false
  end

  create_table "repcat$_ddl", :id => false, :force => true do |t|
    t.decimal "log_id"
    t.string  "source",  :limit => 128
    t.string  "role",    :limit => 1
    t.string  "master",  :limit => 128
    t.integer "line",                    :precision => 38, :scale => 0
    t.string  "text",    :limit => 2000
    t.integer "ddl_num",                 :precision => 38, :scale => 0, :default => 1
  end

  add_index "repcat$_ddl", ["log_id", "source", "role", "master", "line"], :name => "repcat$_ddl", :unique => true
  add_index "repcat$_ddl", ["log_id", "source", "role", "master"], :name => "repcat$_ddl_index"

  add_foreign_key "repcat$_ddl", "repcat$_repcatlog", :columns => ["log_id", "master", "role", "source"], :name => "repcat$_ddl_prnt", :dependent => :delete

  create_table "repcat$_exceptions", :primary_key => "exception_id", :force => true do |t|
    t.string   "user_name",     :limit => 30
    t.text     "request"
    t.decimal  "job"
    t.datetime "error_date"
    t.decimal  "error_number"
    t.string   "error_message", :limit => 4000
    t.decimal  "line_number"
  end

# Could not dump table "repcat$_extension" because of following StandardError
#   Unknown type 'RAW' for column 'extension_id'

# Could not dump table "repcat$_flavor_objects" because of following StandardError
#   Unknown type 'RAW' for column 'hashcode'

  add_foreign_key "repcat$_flavor_objects", "repcat$_flavors", :columns => ["flavor_id", "gname", "gowner"], :name => "repcat$_flavor_objects_fk2", :dependent => :delete
  add_foreign_key "repcat$_flavor_objects", "repcat$_repcat", :columns => ["gname", "gowner"], :name => "repcat$_flavor_objects_fk1", :dependent => :delete

  create_table "repcat$_flavors", :id => false, :force => true do |t|
    t.decimal  "flavor_id",                                         :null => false
    t.string   "gowner",        :limit => 30, :default => "PUBLIC"
    t.string   "gname",         :limit => 30,                       :null => false
    t.string   "fname",         :limit => 30
    t.datetime "creation_date"
    t.decimal  "created_by",                  :default => 0.0
    t.string   "published",     :limit => 1,  :default => "N"
  end

  add_index "repcat$_flavors", ["fname"], :name => "repcat$_flavors_fname"
  add_index "repcat$_flavors", ["gname", "flavor_id", "gowner"], :name => "repcat$_flavors_unq1", :unique => true
  add_index "repcat$_flavors", ["gname", "fname", "gowner"], :name => "repcat$_flavors_gname", :unique => true
  add_index "repcat$_flavors", ["gname", "gowner"], :name => "repcat$_flavors_fk1_idx"

  add_foreign_key "repcat$_flavors", "repcat$_repcat", :columns => ["gname", "gowner"], :name => "repcat$_flavors_fk1", :dependent => :delete

  create_table "repcat$_generated", :id => false, :force => true do |t|
    t.string  "sname",            :limit => 30,                                :null => false
    t.string  "oname",            :limit => 30,                                :null => false
    t.integer "type",                           :precision => 38, :scale => 0, :null => false
    t.decimal "reason"
    t.string  "base_sname",       :limit => 30,                                :null => false
    t.string  "base_oname",       :limit => 30,                                :null => false
    t.integer "base_type",                      :precision => 38, :scale => 0, :null => false
    t.string  "package_prefix",   :limit => 30
    t.string  "procedure_prefix", :limit => 30
    t.string  "distributed",      :limit => 1
  end

  add_index "repcat$_generated", ["base_sname", "base_oname", "base_type"], :name => "repcat$_generated_n1"
  add_index "repcat$_generated", ["sname", "oname", "type"], :name => "repcat$_repgen_prnt_idx"

  add_foreign_key "repcat$_generated", "repcat$_repobject", :columns => ["base_oname", "base_sname", "base_type"], :name => "repcat$_repgen_prnt2", :dependent => :delete
  add_foreign_key "repcat$_generated", "repcat$_repobject", :columns => ["oname", "sname", "type"], :name => "repcat$_repgen_prnt", :dependent => :delete

  create_table "repcat$_grouped_column", :id => false, :force => true do |t|
    t.string  "sname",       :limit => 30, :null => false
    t.string  "oname",       :limit => 30, :null => false
    t.string  "group_name",  :limit => 30, :null => false
    t.string  "column_name", :limit => 30, :null => false
    t.decimal "pos",                       :null => false
  end

  add_index "repcat$_grouped_column", ["sname", "oname", "group_name"], :name => "repcat$_grouped_column_f1_idx"

  add_foreign_key "repcat$_grouped_column", "repcat$_column_group", :columns => ["group_name", "oname", "sname"], :name => "repcat$_grouped_column_f1"

  create_table "repcat$_instantiation_ddl", :id => false, :force => true do |t|
    t.decimal "refresh_template_id", :null => false
    t.text    "ddl_text"
    t.decimal "ddl_num",             :null => false
    t.decimal "phase",               :null => false
  end

  add_foreign_key "repcat$_instantiation_ddl", "repcat$_refresh_templates", :column => "refresh_template_id", :primary_key => nil, :name => "repcat$_instantiation_ddl_fk1", :dependent => :delete

  create_table "repcat$_key_columns", :id => false, :force => true do |t|
    t.string  "sname", :limit => 30,                                :null => false
    t.string  "oname", :limit => 30,                                :null => false
    t.integer "type",                :precision => 38, :scale => 0
    t.string  "col",   :limit => 30,                                :null => false
  end

  add_index "repcat$_key_columns", ["sname", "oname", "type"], :name => "repcat$_key_columns_prnt_idx"

  add_foreign_key "repcat$_key_columns", "repcat$_repobject", :columns => ["oname", "sname", "type"], :name => "repcat$_key_columns_prnt", :dependent => :delete

  create_table "repcat$_object_parms", :id => false, :force => true do |t|
    t.decimal "template_parameter_id", :null => false
    t.decimal "template_object_id",    :null => false
  end

  add_index "repcat$_object_parms", ["template_object_id"], :name => "repcat$_object_parms_n2"

  add_foreign_key "repcat$_object_parms", "repcat$_template_objects", :column => "template_object_id", :primary_key => nil, :name => "repcat$_object_parms_fk2", :dependent => :delete
  add_foreign_key "repcat$_object_parms", "repcat$_template_parms", :column => "template_parameter_id", :primary_key => nil, :name => "repcat$_object_parms_fk1"

# Could not dump table "repcat$_object_types" because of following StandardError
#   Unknown type 'RAW' for column 'flags'

  create_table "repcat$_parameter_column", :id => false, :force => true do |t|
    t.string  "sname",                 :limit => 30,                                  :null => false
    t.string  "oname",                 :limit => 30,                                  :null => false
    t.integer "conflict_type_id",                      :precision => 38, :scale => 0, :null => false
    t.string  "reference_name",        :limit => 30,                                  :null => false
    t.decimal "sequence_no",                                                          :null => false
    t.string  "parameter_table_name",  :limit => 30,                                  :null => false
    t.string  "parameter_column_name", :limit => 4000
    t.decimal "parameter_sequence_no",                                                :null => false
    t.decimal "column_pos",                                                           :null => false
    t.decimal "attribute_sequence_no"
  end

  add_index "repcat$_parameter_column", ["sname", "oname", "conflict_type_id", "reference_name", "sequence_no"], :name => "repcat$_parameter_column_f1_i"

  add_foreign_key "repcat$_parameter_column", "repcat$_resolution", :columns => ["conflict_type_id", "oname", "reference_name", "sequence_no", "sname"], :name => "repcat$_parameter_column_f1"

# Could not dump table "repcat$_priority" because of following StandardError
#   Unknown type 'RAW' for column 'raw_value'

  add_foreign_key "repcat$_priority", "repcat$_priority_group", :columns => ["priority_group", "sname"], :name => "repcat$_priority_f1"

  create_table "repcat$_priority_group", :id => false, :force => true do |t|
    t.string  "sname",             :limit => 30,                                :null => false
    t.string  "priority_group",    :limit => 30,                                :null => false
    t.integer "data_type_id",                    :precision => 38, :scale => 0, :null => false
    t.integer "fixed_data_length",               :precision => 38, :scale => 0
    t.string  "priority_comment",  :limit => 80
  end

  add_index "repcat$_priority_group", ["sname", "priority_group", "data_type_id", "fixed_data_length"], :name => "repcat$_priority_group_u1", :unique => true

# Could not dump table "repcat$_refresh_templates" because of following StandardError
#   Unknown type 'RAW' for column 'flags'

  add_foreign_key "repcat$_refresh_templates", "repcat$_template_status", :column => "template_status_id", :primary_key => nil, :name => "repcat$_refresh_templates_fk2"
  add_foreign_key "repcat$_refresh_templates", "repcat$_template_types", :column => "template_type_id", :primary_key => nil, :name => "repcat$_refresh_templates_fk1"

# Could not dump table "repcat$_repcat" because of following StandardError
#   Unknown type 'RAW' for column 'flag'

  create_table "repcat$_repcatlog", :id => false, :force => true do |t|
    t.decimal  "version"
    t.decimal  "id",                                                          :null => false
    t.string   "source",       :limit => 128,                                 :null => false
    t.string   "userid",       :limit => 30
    t.datetime "timestamp"
    t.string   "role",         :limit => 1,                                   :null => false
    t.string   "master",       :limit => 128,                                 :null => false
    t.string   "sname",        :limit => 30
    t.integer  "request",                      :precision => 38, :scale => 0
    t.string   "oname",        :limit => 30
    t.integer  "type",                         :precision => 38, :scale => 0
    t.string   "a_comment",    :limit => 2000
    t.string   "bool_arg",     :limit => 1
    t.string   "ano_bool_arg", :limit => 1
    t.integer  "int_arg",                      :precision => 38, :scale => 0
    t.integer  "ano_int_arg",                  :precision => 38, :scale => 0
    t.integer  "lines",                        :precision => 38, :scale => 0
    t.integer  "status",                       :precision => 38, :scale => 0
    t.string   "message",      :limit => 200
    t.decimal  "errnum"
    t.string   "gname",        :limit => 30
  end

  add_index "repcat$_repcatlog", ["gname", "sname", "oname", "type"], :name => "repcat$_repcatlog_gname"

# Could not dump table "repcat$_repcolumn" because of following StandardError
#   Unknown type 'RAW' for column 'toid'

  add_foreign_key "repcat$_repcolumn", "repcat$_repobject", :columns => ["oname", "sname", "type"], :name => "repcat$_repcolumn_fk", :dependent => :delete

  create_table "repcat$_repgroup_privs", :id => false, :force => true do |t|
    t.decimal  "userid"
    t.string   "username",    :limit => 30, :null => false
    t.string   "gowner",      :limit => 30
    t.string   "gname",       :limit => 30
    t.decimal  "global_flag",               :null => false
    t.datetime "created",                   :null => false
    t.decimal  "privilege"
  end

  add_index "repcat$_repgroup_privs", ["global_flag", "username"], :name => "repcat$_repgroup_privs_n1"
  add_index "repcat$_repgroup_privs", ["gname", "gowner"], :name => "repcat$_repgroup_privs_fk_idx"
  add_index "repcat$_repgroup_privs", ["username", "gname", "gowner"], :name => "repcat$_repgroup_privs_uk", :unique => true

  add_foreign_key "repcat$_repgroup_privs", "repcat$_repcat", :columns => ["gname", "gowner"], :name => "repcat$_repgroup_privs_fk", :dependent => :delete

# Could not dump table "repcat$_repobject" because of following StandardError
#   Unknown type 'RAW' for column 'hashcode'

  add_foreign_key "repcat$_repobject", "repcat$_repcat", :columns => ["gname", "gowner"], :name => "repcat$_repobject_prnt", :dependent => :delete

# Could not dump table "repcat$_repprop" because of following StandardError
#   Unknown type 'RAW' for column 'extension_id'

  add_foreign_key "repcat$_repprop", "repcat$_repobject", :columns => ["oname", "sname", "type"], :name => "repcat$_repprop_prnt", :dependent => :delete

# Could not dump table "repcat$_repschema" because of following StandardError
#   Unknown type 'RAW' for column 'extension_id'

  add_foreign_key "repcat$_repschema", "def$_destination", :columns => ["dblink", "extension_id"], :name => "repcat$_repschema_dest"
  add_foreign_key "repcat$_repschema", "repcat$_repcat", :columns => ["gowner", "sname"], :name => "repcat$_repschema_prnt", :dependent => :delete

  create_table "repcat$_resol_stats_control", :id => false, :force => true do |t|
    t.string   "sname",                 :limit => 30,                                :null => false
    t.string   "oname",                 :limit => 30,                                :null => false
    t.datetime "created",                                                            :null => false
    t.integer  "status",                              :precision => 38, :scale => 0, :null => false
    t.datetime "status_update_date",                                                 :null => false
    t.datetime "purged_date"
    t.datetime "last_purge_start_date"
    t.datetime "last_purge_end_date"
  end

  create_table "repcat$_resolution", :id => false, :force => true do |t|
    t.string  "sname",              :limit => 30,                                :null => false
    t.string  "oname",              :limit => 30,                                :null => false
    t.integer "conflict_type_id",                 :precision => 38, :scale => 0, :null => false
    t.string  "reference_name",     :limit => 30,                                :null => false
    t.decimal "sequence_no",                                                     :null => false
    t.string  "method_name",        :limit => 80,                                :null => false
    t.string  "function_name",      :limit => 92,                                :null => false
    t.string  "priority_group",     :limit => 30
    t.string  "resolution_comment", :limit => 80
  end

  add_index "repcat$_resolution", ["conflict_type_id", "method_name"], :name => "repcat$_resolution_f3_idx"
  add_index "repcat$_resolution", ["sname", "oname", "conflict_type_id", "reference_name"], :name => "repcat$_resolution_idx2"

  add_foreign_key "repcat$_resolution", "repcat$_conflict", :columns => ["conflict_type_id", "oname", "reference_name", "sname"], :name => "repcat$_resolution_f3"
  add_foreign_key "repcat$_resolution", "repcat$_resolution_method", :columns => ["conflict_type_id", "method_name"], :name => "repcat$_resolution_f1"

  create_table "repcat$_resolution_method", :id => false, :force => true do |t|
    t.integer "conflict_type_id",               :precision => 38, :scale => 0, :null => false
    t.string  "method_name",      :limit => 80,                                :null => false
  end

  create_table "repcat$_resolution_statistics", :id => false, :force => true do |t|
    t.string   "sname",             :limit => 30,                                  :null => false
    t.string   "oname",             :limit => 30,                                  :null => false
    t.integer  "conflict_type_id",                  :precision => 38, :scale => 0, :null => false
    t.string   "reference_name",    :limit => 30,                                  :null => false
    t.string   "method_name",       :limit => 80,                                  :null => false
    t.string   "function_name",     :limit => 92,                                  :null => false
    t.string   "priority_group",    :limit => 30
    t.datetime "resolved_date",                                                    :null => false
    t.string   "primary_key_value", :limit => 2000,                                :null => false
  end

  add_index "repcat$_resolution_statistics", ["sname", "oname", "resolved_date", "conflict_type_id", "reference_name", "method_name", "function_name", "priority_group"], :name => "repcat$_resolution_stats_n1"

  create_table "repcat$_runtime_parms", :id => false, :force => true do |t|
    t.decimal "runtime_parm_id"
    t.string  "parameter_name",  :limit => 30
    t.text    "parm_value"
  end

  add_index "repcat$_runtime_parms", ["runtime_parm_id", "parameter_name"], :name => "repcat$_runtime_parms_pk", :unique => true

  create_table "repcat$_site_objects", :id => false, :force => true do |t|
    t.decimal "template_site_id",               :null => false
    t.string  "sname",            :limit => 30
    t.string  "oname",            :limit => 30, :null => false
    t.decimal "object_type_id",                 :null => false
  end

  add_index "repcat$_site_objects", ["template_site_id", "oname", "object_type_id", "sname"], :name => "repcat$_site_objects_u1", :unique => true
  add_index "repcat$_site_objects", ["template_site_id"], :name => "repcat$_site_objects_n1"

  add_foreign_key "repcat$_site_objects", "repcat$_object_types", :column => "object_type_id", :primary_key => nil, :name => "repcat$_site_objects_fk1"
  add_foreign_key "repcat$_site_objects", "repcat$_template_sites", :column => "template_site_id", :primary_key => nil, :name => "repcat$_site_object_fk2", :dependent => :delete

# Could not dump table "repcat$_sites_new" because of following StandardError
#   Unknown type 'RAW' for column 'extension_id'

  add_foreign_key "repcat$_sites_new", "repcat$_extension", :column => "extension_id", :primary_key => nil, :name => "repcat$_sites_new_fk1", :dependent => :delete
  add_foreign_key "repcat$_sites_new", "repcat$_repcat", :columns => ["gname", "gowner"], :name => "repcat$_sites_new_fk2", :dependent => :delete

  create_table "repcat$_snapgroup", :id => false, :force => true do |t|
    t.string  "gowner",        :limit => 30,  :default => "PUBLIC"
    t.string  "gname",         :limit => 30
    t.string  "dblink",        :limit => 128
    t.string  "group_comment", :limit => 80
    t.decimal "rep_type"
    t.decimal "flavor_id"
  end

  add_index "repcat$_snapgroup", ["gname", "dblink", "gowner"], :name => "i_repcat$_snapgroup1", :unique => true

# Could not dump table "repcat$_template_objects" because of following StandardError
#   Unknown type 'RAW' for column 'flags'

  add_foreign_key "repcat$_template_objects", "repcat$_object_types", :column => "object_type", :primary_key => nil, :name => "repcat$_template_objects_fk3"
  add_foreign_key "repcat$_template_objects", "repcat$_refresh_templates", :column => "refresh_template_id", :primary_key => nil, :name => "repcat$_template_objects_fk1", :dependent => :delete

  create_table "repcat$_template_parms", :primary_key => "template_parameter_id", :force => true do |t|
    t.decimal "refresh_template_id",                                  :null => false
    t.string  "parameter_name",      :limit => 30,                    :null => false
    t.text    "default_parm_value"
    t.string  "prompt_string",       :limit => 2000
    t.string  "user_override",       :limit => 1,    :default => "Y"
  end

  add_index "repcat$_template_parms", ["refresh_template_id", "parameter_name"], :name => "repcat$_template_parms_u1", :unique => true

  add_foreign_key "repcat$_template_parms", "repcat$_refresh_templates", :column => "refresh_template_id", :primary_key => nil, :name => "repcat$_template_parms_fk1", :dependent => :delete

  create_table "repcat$_template_refgroups", :primary_key => "refresh_group_id", :force => true do |t|
    t.string  "refresh_group_name",  :limit => 30,  :null => false
    t.decimal "refresh_template_id",                :null => false
    t.string  "rollback_seg",        :limit => 30
    t.string  "start_date",          :limit => 200
    t.string  "interval",            :limit => 200
  end

  add_index "repcat$_template_refgroups", ["refresh_group_name"], :name => "repcat$_template_refgroups_n1"
  add_index "repcat$_template_refgroups", ["refresh_template_id"], :name => "repcat$_template_refgroups_n2"

  add_foreign_key "repcat$_template_refgroups", "repcat$_refresh_templates", :column => "refresh_template_id", :primary_key => nil, :name => "repcat$_template_refgroups_fk1", :dependent => :delete

  create_table "repcat$_template_sites", :primary_key => "template_site_id", :force => true do |t|
    t.string   "refresh_template_name", :limit => 30,  :null => false
    t.string   "refresh_group_name",    :limit => 30
    t.string   "template_owner",        :limit => 30
    t.string   "user_name",             :limit => 30,  :null => false
    t.string   "site_name",             :limit => 128
    t.decimal  "repapi_site_id"
    t.decimal  "status",                               :null => false
    t.decimal  "refresh_template_id"
    t.decimal  "user_id"
    t.datetime "instantiation_date"
  end

  add_index "repcat$_template_sites", ["refresh_template_name", "user_name", "site_name", "repapi_site_id"], :name => "repcat$_template_sites_u1", :unique => true

  create_table "repcat$_template_status", :primary_key => "template_status_id", :force => true do |t|
    t.string "status_type_name", :limit => 100, :null => false
  end

  create_table "repcat$_template_targets", :primary_key => "template_target_id", :force => true do |t|
    t.string "target_database", :limit => 128,  :null => false
    t.string "target_comment",  :limit => 2000
    t.string "connect_string",  :limit => 4000
    t.string "spare1",          :limit => 4000
  end

  add_index "repcat$_template_targets", ["target_database"], :name => "repcat$_template_targets_u1", :unique => true

# Could not dump table "repcat$_template_types" because of following StandardError
#   Unknown type 'RAW' for column 'flags'

  create_table "repcat$_user_authorizations", :primary_key => "user_authorization_id", :force => true do |t|
    t.decimal "user_id",             :null => false
    t.decimal "refresh_template_id", :null => false
  end

  add_index "repcat$_user_authorizations", ["refresh_template_id"], :name => "repcat$_user_authorizations_n1"
  add_index "repcat$_user_authorizations", ["user_id", "refresh_template_id"], :name => "repcat$_user_authorizations_u1", :unique => true

  add_foreign_key "repcat$_user_authorizations", "repcat$_refresh_templates", :column => "refresh_template_id", :primary_key => nil, :name => "repcat$_user_authorization_fk2", :dependent => :delete

  create_table "repcat$_user_parm_values", :primary_key => "user_parameter_id", :force => true do |t|
    t.decimal "template_parameter_id", :null => false
    t.decimal "user_id",               :null => false
    t.text    "parm_value"
  end

  add_index "repcat$_user_parm_values", ["template_parameter_id", "user_id"], :name => "repcat$_user_parm_values_u1", :unique => true

  add_foreign_key "repcat$_user_parm_values", "repcat$_template_parms", :column => "template_parameter_id", :primary_key => nil, :name => "repcat$_user_parm_values_fk1", :dependent => :delete

  create_table "requisiciones", :primary_key => "requisicion_id", :force => true do |t|
    t.integer  "usuario_id",   :limit => 10,  :precision => 10, :scale => 0
    t.integer  "proveedor_id", :limit => 10,  :precision => 10, :scale => 0
    t.datetime "fecha"
    t.float    "total",        :limit => 126,                                :null => false
    t.string   "estatus",      :limit => 20,                                 :null => false
  end

  add_foreign_key "requisiciones", "proveedores", :column => "proveedor_id", :primary_key => nil, :name => "fkey_prov"
  add_foreign_key "requisiciones", "usuarios", :name => "fkey_usuarios"

  create_table "requisiciones_articulos", :id => false, :force => true do |t|
    t.integer "requisicion_id", :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer "articulo_id",    :limit => 10,  :precision => 10, :scale => 0, :null => false
    t.integer "cantidad",       :limit => 5,   :precision => 5,  :scale => 0, :null => false
    t.float   "precio",         :limit => 126,                                :null => false
    t.float   "sub_total",      :limit => 126,                                :null => false
  end

  add_foreign_key "requisiciones_articulos", "articulos", :primary_key => nil, :name => "fkey_arts"
  add_foreign_key "requisiciones_articulos", "requisiciones", :column => "requisicion_id", :primary_key => nil, :name => "fkey_requi"

  create_table "salidas", :primary_key => "salida_id", :force => true do |t|
    t.integer  "articulo_id",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "usuario_salida_id", :limit => 10, :precision => 10, :scale => 0
    t.integer  "cantidad",          :limit => 5,  :precision => 5,  :scale => 0
    t.datetime "fecha"
  end

  add_foreign_key "salidas", "articulos", :primary_key => nil, :name => "fkey_art_sal"
  add_foreign_key "salidas", "usuarios", :column => "usuario_salida_id", :name => "fkey_usu_sal"

# Could not dump table "sqlplus_product_profile" because of following StandardError
#   Unknown type 'LONG' for column 'long_value'

  create_table "tipo_usuario", :primary_key => "tipo_usuario_id", :force => true do |t|
    t.string "tipo",        :limit => 10,  :null => false
    t.string "descripcion", :limit => 200
  end

  create_table "usuarios", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100,                                :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "area_id",                   :limit => 10,  :precision => 10, :scale => 0
    t.string   "direccion",                 :limit => 100
    t.integer  "tipo_usuario_id",           :limit => 10,  :precision => 10, :scale => 0
    t.string   "telefono",                  :limit => 20
    t.string   "usuario_pass"
  end

  add_index "usuarios", ["login"], :name => "index_usuarios_on_login", :unique => true

  add_foreign_key "usuarios", "areas", :primary_key => nil, :name => "fkey_area"
  add_foreign_key "usuarios", "tipo_usuario", :primary_key => nil, :name => "fkey_tipo_usuario"

  add_synonym "syscatalog", "sys.syscatalog", :force => true
  add_synonym "catalog", "sys.catalog", :force => true
  add_synonym "tab", "sys.tab", :force => true
  add_synonym "col", "sys.col", :force => true
  add_synonym "tabquotas", "sys.tabquotas", :force => true
  add_synonym "sysfiles", "sys.sysfiles", :force => true
  add_synonym "publicsyn", "sys.publicsyn", :force => true
  add_synonym "product_user_profile", "system.sqlplus_product_profile", :force => true

end
