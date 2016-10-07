# frozen_string_literal: true
class CreateFlashcards < ActiveRecord::Migration[5.0]
  def change
    create_table :flashcards do |t|
      t.text :front
      t.text :back
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true

      t.timestamps
    end
  end
end
