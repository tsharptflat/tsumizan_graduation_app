class FixFriendshipLevelEnumValues < ActiveRecord::Migration[7.2]
  def up
    execute "UPDATE tasks SET task_genre = 2 WHERE task_genre = 3"
    execute "UPDATE task_conditions SET condition_type = 2 WHERE condition_type = 3"
  end

  def down
    execute "UPDATE tasks SET task_genre = 3 WHERE task_genre = 2"
    execute "UPDATE task_conditions SET condition_type = 3 WHERE condition_type = 2"
  end
end
