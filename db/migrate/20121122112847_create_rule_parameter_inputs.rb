class CreateRuleParameterInputs < ActiveRecord::Migration
  def change
    create_table :rule_parameter_inputs do |t|
      t.string :rule
      t.timestamps
    end

    add_column :parameters, :rule_parameter_input_id, :integer

    add_foreign_key :parameters, :rule_parameter_inputs
  end
end
