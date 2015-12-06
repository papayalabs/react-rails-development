class CreateServicePayments < ActiveRecord::Migration
  def change
    create_table :service_payments, :id => false do |t|
      t.string :id, :limit => 36, :primary => true  
      t.string :payment_id
      t.string :state
      t.string :amount
      t.string :description
      t.string :period
      t.string :domain

      t.timestamps
    end
  end
end
