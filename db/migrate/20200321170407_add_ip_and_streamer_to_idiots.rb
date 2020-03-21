class AddIpAndStreamerToIdiots < ActiveRecord::Migration[6.0]
  def change
    add_column :idiots, :ip, :string
    add_column :idiots, :streamer, :boolean, default: false
  end
end
