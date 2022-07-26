class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :owner
      t.string :expenseName
      t.float :cost

      t.timestamps
    end
  end
end
