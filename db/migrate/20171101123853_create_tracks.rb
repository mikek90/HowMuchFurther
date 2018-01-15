class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.references :user, foreign_key: true
      
      t.string :title, null: false
      t.string :latitude_from, null: false
      t.string :longtitude_from, null: false
      t.string :latitude_to, null: false
      t.string :longtitude_to, null: false
      t.string :json_response
      t.string :json_processed

      t.timestamps
    end
  end
end
