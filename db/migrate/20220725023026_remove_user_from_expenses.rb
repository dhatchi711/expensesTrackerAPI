class RemoveUserFromExpenses < ActiveRecord::Migration[7.0]
  def change
    remove_column :expenses, :owner, :string
  end
end
