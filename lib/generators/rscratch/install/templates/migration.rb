class RscratchSchemaMigration < ActiveRecord::Migration
  def change
    # Exception table
    create_table :rscratch_exceptions do |t|
      t.text :exception
      t.text :message
      t.string :controller
      t.string :action
      t.string :app_environment
      t.integer :total_occurance_count
      t.integer :new_occurance_count
      t.string :status

      t.timestamps
    end

    # Exception log table
    create_table :rscratch_exception_logs do |t|
      t.integer :exception_id
      t.text :description
      t.text :backtrace
      t.text :request_url
      t.string :request_method
      t.text :parameters
      t.string :user_agent
      t.string :client_ip
      t.string :status

      t.timestamps
    end 

    # Config table
    create_table :rscratch_configurations do |tc|
      tc.string  :config_key
      tc.string  :config_value

      tc.timestamps
    end      
  end
end