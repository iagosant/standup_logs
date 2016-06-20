class AddTeamIdToSessionModel < ActiveRecord::Migration
  def up
    add_column :sessions, :team_id, :integer
    add_index  :sessions, :team_id
  end
  def down
    remove_column :sessions, :team_id, :integer
    remove_index  :sessions, :team_id
  end
end
