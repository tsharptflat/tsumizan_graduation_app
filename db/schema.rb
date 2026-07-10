# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_07_04_120000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_expressions", force: :cascade do |t|
    t.bigint "character_type_id", null: false
    t.string "emotion_type", null: false
    t.string "image_path", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_type_id", "emotion_type"], name: "idx_char_expressions_on_type_and_emotion", unique: true
    t.index ["character_type_id"], name: "index_character_expressions_on_character_type_id"
  end

  create_table "character_text_conditions", force: :cascade do |t|
    t.bigint "character_type_id", null: false
    t.string "page", null: false
    t.integer "friendship_level", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_price"
    t.integer "max_price"
    t.index ["character_type_id", "page", "friendship_level", "min_price"], name: "idx_char_text_cond_on_type_page_level_price", unique: true
    t.index ["character_type_id"], name: "index_character_text_conditions_on_character_type_id"
  end

  create_table "character_texts", force: :cascade do |t|
    t.bigint "character_text_condition_id", null: false
    t.bigint "character_expression_id"
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_expression_id"], name: "index_character_texts_on_character_expression_id"
    t.index ["character_text_condition_id"], name: "index_character_texts_on_character_text_condition_id"
  end

  create_table "character_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_character_types_on_name", unique: true
  end

  create_table "game_genre_types", force: :cascade do |t|
    t.integer "genre_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_genres", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "game_genre_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_genre_type_id"], name: "index_game_genres_on_game_genre_type_id"
    t.index ["game_id"], name: "index_game_genres_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "game_title"
    t.integer "steam_app_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["steam_app_id"], name: "index_games_on_steam_app_id", unique: true
  end

  create_table "gift_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "friendship_point", default: 0
    t.string "image_path"
    t.string "description"
  end

  create_table "outfit_items", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_outfit_items_on_name", unique: true
  end

  create_table "shop_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type"
    t.bigint "item_id"
    t.integer "quantity"
    t.float "price"
    t.index ["item_type", "item_id"], name: "index_shop_items_on_item"
  end

  create_table "task_conditions", force: :cascade do |t|
    t.bigint "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "condition_type"
    t.integer "required_count"
    t.index ["task_id"], name: "index_task_conditions_on_task_id"
  end

  create_table "task_rewards", force: :cascade do |t|
    t.bigint "task_id"
    t.string "item_type"
    t.bigint "item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point"
    t.index ["item_type", "item_id"], name: "index_task_rewards_on_item"
    t.index ["task_id"], name: "index_task_rewards_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "task_genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_characters", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "character_type_id", null: false
    t.string "name", null: false
    t.integer "friendship_point", default: 0, null: false
    t.bigint "outfit_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_type_id"], name: "index_user_characters_on_character_type_id"
    t.index ["outfit_item_id"], name: "index_user_characters_on_outfit_item_id"
    t.index ["user_id"], name: "index_user_characters_on_user_id"
  end

  create_table "user_game_libraries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "minutes_played", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.datetime "last_played_at"
    t.date "cleared_date"
    t.date "unplayed_date"
    t.index ["game_id"], name: "index_user_game_libraries_on_game_id"
    t.index ["user_id", "game_id"], name: "index_user_game_libraries_on_user_id_and_game_id", unique: true
    t.index ["user_id"], name: "index_user_game_libraries_on_user_id"
  end

  create_table "user_gift_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "gift_item_id"
    t.integer "quantity"
    t.index ["gift_item_id"], name: "index_user_gift_items_on_gift_item_id"
    t.index ["user_id"], name: "index_user_gift_items_on_user_id"
  end

  create_table "user_outfit_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "outfit_item_id"
    t.index ["outfit_item_id"], name: "index_user_outfit_items_on_outfit_item_id"
    t.index ["user_id"], name: "index_user_outfit_items_on_user_id"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "task_id"
    t.integer "current_value"
    t.datetime "completed_at"
    t.datetime "accepted_reward_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_user_tasks_on_task_id"
    t.index ["user_id"], name: "index_user_tasks_on_user_id"
  end

  create_table "user_wallets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "point", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wallets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
  end

  add_foreign_key "character_expressions", "character_types"
  add_foreign_key "character_text_conditions", "character_types"
  add_foreign_key "character_texts", "character_expressions"
  add_foreign_key "character_texts", "character_text_conditions"
  add_foreign_key "game_genres", "game_genre_types"
  add_foreign_key "game_genres", "games"
  add_foreign_key "task_conditions", "tasks"
  add_foreign_key "task_rewards", "tasks"
  add_foreign_key "user_characters", "character_types"
  add_foreign_key "user_characters", "outfit_items"
  add_foreign_key "user_characters", "users"
  add_foreign_key "user_game_libraries", "games"
  add_foreign_key "user_game_libraries", "users"
  add_foreign_key "user_outfit_items", "outfit_items"
  add_foreign_key "user_outfit_items", "users"
  add_foreign_key "user_tasks", "tasks"
  add_foreign_key "user_tasks", "users"
  add_foreign_key "user_wallets", "users"
end
