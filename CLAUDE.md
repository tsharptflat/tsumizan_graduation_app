# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this app is

「積み算」("Tsumi-zan") is a portfolio app for managing a Steam game backlog ("積みゲー" / unplayed-but-purchased games). Users sign in via Steam OpenID, their library and playtime sync from the Steam Web API, and the app surfaces the total yen value of unplayed games, recommends what to play next, and gives feedback through an original character. See [README.md](README.md) for the full product spec (target users, MVP scope, competitive analysis).

Stack: Ruby on Rails 7.2 (Slim templates, Bootstrap 5, importmap-free esbuild/jsbundling), PostgreSQL, Sidekiq + Redis for background jobs, Devise + omniauth-steam for auth, all run via Docker Compose.

## Development commands

All commands run inside the Docker containers (`web`, `db`, `redis`, `sidekiq`).

```bash
docker compose up                                    # start db, web, redis, sidekiq (web runs bundle install + db:prepare + bin/dev on boot)
docker compose exec web bin/rails console
docker compose exec web bin/rails db:migrate
docker compose exec web bin/rails db:prepare         # create/migrate/seed as needed

# Tests (RSpec)
docker compose exec web bundle exec rspec                          # full suite
docker compose exec web bundle exec rspec spec/models/task_spec.rb # single file
docker compose exec web bundle exec rspec spec/models/task_spec.rb:12  # single example by line

# Lint
docker compose exec web bundle exec rubocop
docker compose exec web bundle exec rubocop -a       # autocorrect

# Security scan
docker compose exec web bundle exec brakeman
```

`bin/dev` (via `Procfile.dev`) runs the Rails server plus `yarn build --watch` (JS) and `yarn watch:css` (Sass) concurrently — this is what starts inside the `web` container automatically.

Sidekiq web UI is mounted at `/sidekiq`.

## Architecture

### Steam data sync flow
- `SteamService` (app/services/steam_service.rb) wraps the Steam Web API (`IPlayerService/GetOwnedGames`) to fetch a user's owned games list.
- `SteamApiService` (app/services/steam_api_service.rb) wraps the unofficial Steam Store API (`store.steampowered.com/api/appdetails`) to fetch a single game's JPY price and genres — this is per-`steam_app_id`, called lazily.
- `UserGameLibrary.sync_game_playtime_and_price(user, data)` is the central write path: it upserts a `Game` by `steam_app_id`, upserts the user's `UserGameLibrary` row (playtime, last-played, computed `unplayed_date`), then enqueues `UpdateGamePriceJob`/`UpdateGameGenreJob` as Sidekiq jobs if price/genre data is still missing. Price and genre fetching is deliberately deferred to background jobs since it requires a separate external API call per game.
- "積みゲー" (backlog) status is derived, not stored as a flag: `UserGameLibrary.unplayed` scope combines `not_recently_played` (no play in the last month), `not_cleared`, and a playtime threshold (`UNPLAYED_THRESHOLD_MINUTES = 120`). Read the scope chain in `UserGameLibrary` before adding backlog-related features — most "is this game in the backlog" logic should reuse these scopes rather than reimplementing the conditions.

### Auth
Devise handles sessions; `omniauth-steam` handles the actual Steam OpenID login (`Users::OmniauthCallbacksController`, `User.from_omniauth`). There's no password auth — `provider`/`uid` from Steam is the identity. `ApplicationController` requires authentication on all non-Devise controllers by default (`before_action :authenticate_user!, unless: :devise_controller?`).

### Mileage / missions feature (in progress)
A gamification layer being added on top of the core backlog tracker, so users earn points/items for backlog-clearing behavior. Table relationships:

- `Task` (a mission, `task_genre` enum: `tsumige`/`playtime`/`trophies`/`friendship_level`) has many `TaskCondition` (completion requirements: `condition_type` + `required_count`) and `TaskReward` (payout).
- `TaskReward` and `ShopItem` both `belongs_to :item, polymorphic: true` — `item` is either a `GiftItem` or an `OutfitItem`. This lets both mission rewards and shop purchases reference the same reward-item tables without duplicating them per item type.
- `UserTask`, `UserGiftItem`, `UserOutfitItem` are the join tables recording what a given user has completed/owns; `User#tasks`, `#gift_items`, `#outfit_items` are `has_many :through` these joins — **the join-table `has_many` itself must also be declared on `User` for `through:` to resolve** (this is the gap currently being fixed).
- `UserWallet` (`belongs_to :user`, one per user) holds the spendable `point` balance used to "buy" `ShopItem`s.
- `OutfitItem` also connects to the character system: `UserCharacter belongs_to :outfit_item, optional: true` — earned/purchased outfits can be equipped on a user's character.

This feature is mid-implementation: models exist and migrations are applied, but associations are incomplete and no service/controller logic exists yet for granting rewards or checking task completion.

### Character / dialogue system
`CharacterType` → `CharacterExpression` (emotion variants) and `CharacterTextCondition` (unlock conditions, gated by `friendship_level`) → `CharacterText` (actual dialogue lines, optionally tied to an expression). `CharacterTextService` (app/services/character_text_service.rb) is the entry point for selecting which line to show. `UserCharacter.find_or_create_default_character` auto-provisions a default character (`character_type_id` for `'いらすと子'`) for new users.

### Statistics
`StatisticsController#show` is the main dashboard aggregation point — it's the reference for how backlog stats (`total_price`, `unplayed_game_genres`, `cleared_game_count_rate`, recommendations) are pulled together from `UserGameLibrary` class methods. New stats/mileage displays likely belong alongside this pattern rather than as ad-hoc controller queries.

## Conventions
- Rubocop uses `rubocop-rails-omakase` as the base config; single-quoted strings are explicitly allowed (`Style/StringLiterals` disabled) despite the omakase default, so don't "fix" single quotes to double quotes.
- Models in this codebase mix 2-space and 4-space indentation inconsistently (compare `game.rb` vs `task.rb`) — match the surrounding file rather than assuming one style project-wide, unless asked to normalize it.
