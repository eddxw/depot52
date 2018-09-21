class MigratePayTypesInOrders < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE orders SET pay_type_id = pay_type;
        SQL
      end
      dir.down do
        execute <<-SQL
          UPDATE orders SET pay_type = pay_type_id;
        SQL
      end
    end
  end
end
