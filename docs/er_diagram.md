### ユーザー・ゲーム（アプリの中心）

```mermaid
erDiagram
  users {
    bigint id PK
    string name "Steamのユーザー名"
    string provider "steam"
    string uid "SteamID"
  }
  games {
    bigint id PK
    integer steam_app_id UK "SteamのアプリID"
    string game_title
    integer price "定価(円) 未取得はnull"
    datetime price_fetch_failed_at "価格取得を諦めた日時"
  }
  user_game_libraries {
    bigint id PK
    bigint user_id FK
    bigint game_id FK
    float minutes_played "プレイ時間(分)"
    datetime last_played_at
    date unplayed_date "積みゲーになった日"
    date cleared_date "クリアした日"
    integer play_focus "今プレイ中/次にプレイ"
  }
  game_genre_types {
    bigint id PK
    integer genre_id "SteamのジャンルID"
    string name
  }
  game_genres {
    bigint id PK
    bigint game_id FK
    bigint game_genre_type_id FK
  }
  user_statistic_snapshots {
    bigint id PK
    bigint user_id FK
    date recorded_on "記録日(1ユーザー1日1件)"
    integer total_price "積みゲー総額"
    decimal unplayed_rate "積みゲー率"
  }

  users ||--o{ user_game_libraries : "所持"
  games ||--o{ user_game_libraries : "所持される"
  games ||--o{ game_genres : ""
  game_genre_types ||--o{ game_genres : ""
  users ||--o{ user_statistic_snapshots : "推移グラフの記録"
```

### マイレージ（タスク・ショップ）

```mermaid
erDiagram
  users {
    bigint id PK
  }
  user_wallets {
    bigint id PK
    bigint user_id FK
    integer point "所持ポイント"
  }
  tasks {
    bigint id PK
    string name
    string description
    integer task_genre "積みゲー/プレイ時間/好感度"
  }
  task_conditions {
    bigint id PK
    bigint task_id FK
    integer condition_type
    integer required_count "達成に必要な数"
  }
  task_rewards {
    bigint id PK
    bigint task_id FK
    string item_type "GiftItem or OutfitItem"
    bigint item_id "ポリモーフィック関連"
    integer quantity
    integer point "報酬ポイント"
  }
  user_tasks {
    bigint id PK
    bigint user_id FK
    bigint task_id FK
    integer current_value "現在の進捗"
    datetime completed_at "達成日時"
    datetime accepted_reward_at "報酬受取日時"
  }
  shop_items {
    bigint id PK
    string item_type "GiftItem or OutfitItem"
    bigint item_id "ポリモーフィック関連"
    float price "交換に必要なポイント"
  }
  gift_items {
    bigint id PK
    string name
    string description
    string image_path
    integer friendship_point "渡すと上がる好感度"
  }
  user_gift_items {
    bigint id PK
    bigint user_id FK
    bigint gift_item_id FK
    integer quantity "所持数"
  }
  outfit_items {
    bigint id PK
    string name UK
    string description
    string image_path
  }
  user_outfit_items {
    bigint id PK
    bigint user_id FK
    bigint outfit_item_id FK
  }

  users ||--o| user_wallets : ""
  users ||--o{ user_tasks : ""
  tasks ||--o{ user_tasks : ""
  tasks ||--o| task_conditions : "達成条件"
  tasks ||--o{ task_rewards : "報酬"
  task_rewards }o--o| gift_items : "item"
  task_rewards }o--o| outfit_items : "item"
  shop_items }o--o| gift_items : "item"
  shop_items }o--o| outfit_items : "item"
  users ||--o{ user_gift_items : ""
  gift_items ||--o{ user_gift_items : ""
  users ||--o{ user_outfit_items : ""
  outfit_items ||--o{ user_outfit_items : ""
```

### キャラクター

```mermaid
erDiagram
  users {
    bigint id PK
  }
  outfit_items {
    bigint id PK
  }
  character_types {
    bigint id PK
    string name UK
    string image_path
  }
  user_characters {
    bigint id PK
    bigint user_id FK
    bigint character_type_id FK
    bigint outfit_item_id FK "装着中の衣装"
    string name
    integer friendship_point "好感度"
  }
  character_expressions {
    bigint id PK
    bigint character_type_id FK
    string emotion_type "表情の種類"
    string image_path
  }
  character_text_conditions {
    bigint id PK
    bigint character_type_id FK
    string page "表示するページ"
    integer friendship_level "必要な好感度レベル"
    integer min_price "積みゲー総額の下限"
    integer max_price "積みゲー総額の上限"
  }
  character_texts {
    bigint id PK
    bigint character_text_condition_id FK
    bigint character_expression_id FK
    text text "セリフ"
  }

  users ||--o{ user_characters : ""
  character_types ||--o{ user_characters : ""
  outfit_items |o--o{ user_characters : "装着"
  character_types ||--o{ character_expressions : "表情差分"
  character_types ||--o{ character_text_conditions : "セリフの出現条件"
  character_text_conditions ||--o{ character_texts : ""
  character_expressions |o--o{ character_texts : ""
```

- `created_at` / `updated_at` は全テーブル共通のため省略
- 複数の図にまたがるテーブル(`users`、`outfit_items`)は、2枚目以降では `id` のみ記載
- `task_rewards` と `shop_items` の `item` は、`item_type`(GiftItem / OutfitItem)と `item_id` によるポリモーフィック関連
- `contacts`(お問い合わせ)は他のテーブルと関連を持たないため省略
