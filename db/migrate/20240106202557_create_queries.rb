class CreateQueries < ActiveRecord::Migration[7.0]
  def change
    create_table :queries do |t|
      t.text :user_ip
      t.text :search

      t.timestamps
    end
  end
end
