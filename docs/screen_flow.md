### ログインからマイページまで

```mermaid
flowchart LR
  top["トップ<br/>（積みゲー金額ランキング）"]
  steam["Steamログイン<br/>（外部サイト）"]
  loading["ライブラリ同期<br/>（画面なし）"]
  mypage["マイページ<br/>（積みゲー総額＋キャラ）"]
  statistic["積みゲー統計"]
  share["シェアページ<br/>（ログイン不要）"]

  top -->|Steamアカウントでログイン| steam
  steam -->|認証成功| loading
  loading -->|自動で遷移| mypage
  mypage -->|積みゲー統計へ| statistic
  mypage -.->|Xで共有| share
  share -.->|アプリを見る| top
```

### 積みゲー分析

```mermaid
flowchart LR
  statistic["積みゲー統計<br/>（推移グラフ・ネクストプレイ提案<br/>逆レコメンド・コスパランキング）"]
  ranking["コスパランキング詳細"]
  backlog["あなたの積みゲー一覧"]
  games["みんなのゲーム一覧<br/>（ヘッダーの検索結果）"]
  game["ゲーム詳細"]
  focus["プレイ状況<br/>（今プレイ中 / 次にプレイ）"]
  picker["ゲーム選択"]

  statistic --> ranking
  statistic --> backlog
  statistic -->|次にプレイに設定| focus
  statistic --> game
  ranking --> game
  backlog --> game
  games --> game
  focus --> game
  focus -->|ゲームを選ぶ| picker
  picker -->|設定する| focus
```

### 積みゲーマイレージ

```mermaid
flowchart LR
  character["キャラ交流<br/>（話す・プレゼントを渡す）"]
  shop["マイレージショップ<br/>（ポイントでアイテムと交換）"]
  tasks["マイレージ確認<br/>（タスクの報酬を受け取る）"]

  character -->|プレゼントがない時| shop
  character -->|プレゼントがない時| tasks
```

- ログイン後の各画面（マイページ・積みゲー統計・積みゲー一覧・みんなのゲーム一覧・プレイ状況・マイレージ確認・ショップ・キャラ交流）へは、全ページ共通のヘッダーメニューから移動できる。ヘッダーの検索では、候補からゲーム詳細へ直接移動できる
- 全ページ共通のフッターから、利用規約・プライバシーポリシー・クレジット・お問い合わせ（入力 → 確認 → 完了）へ移動できる
- 点線は、外部サービス（X）を経由した遷移
