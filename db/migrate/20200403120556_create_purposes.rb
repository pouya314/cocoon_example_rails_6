class CreatePurposes < ActiveRecord::Migration[6.0]
  def change
    create_table :purposes do |t|
      t.string :name
      t.belongs_to :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
