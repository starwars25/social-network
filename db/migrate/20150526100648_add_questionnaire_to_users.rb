class AddQuestionnaireToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :school, :string
    add_column :users, :university, :string
    add_column :users, :occupation, :string
  end
end
