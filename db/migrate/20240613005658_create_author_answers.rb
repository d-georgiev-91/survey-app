class CreateAuthorAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :author_answers do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
