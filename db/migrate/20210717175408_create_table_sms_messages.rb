class CreateTableSmsMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :table_sms_messages do |t|
      t.string :mobile_number
      t.string :message
    end
  end
end