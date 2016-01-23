class CreateRscratchExceptions < ActiveRecord::Migration
  def change
    create_table :rscratch_exceptions do |t|
      t.text :exception
      t.text :message
      t.string :controller
      t.string :action
      t.string :app_environment
      t.integer :total_occurance_count
      t.integer :new_occurance_count

      t.timestamps
    end
  end
end
