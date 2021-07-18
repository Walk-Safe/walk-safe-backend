class CreateTableSmsMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :sms_messages do |t|
      t.string :mobile_number
      t.string :message
      t.timestamps
    end
  end
end
