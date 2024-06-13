class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.text :content
      t.datetime :end_date
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
