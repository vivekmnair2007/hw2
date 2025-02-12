class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.integer "movie_id"
      t.string "character_name"
      t.integer "actor_id"
      t.timestamps
    end
  end
end
