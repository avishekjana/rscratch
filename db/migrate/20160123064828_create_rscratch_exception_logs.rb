class CreateRscratchExceptionLogs < ActiveRecord::Migration
  def change
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
  end
end
