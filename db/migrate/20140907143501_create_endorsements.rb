class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.string :name
      t.string :lastname
      t.string :doctype
      t.string :docid
      t.string :email
      t.date :birthdate
      t.string :postal_code
      t.string :activity
      t.boolean :subscribed
      t.boolean :hidden
      t.boolean :featured

      t.timestamps
    end
    add_index :endorsements, :lastname
    add_index :endorsements, :docid
    add_index :endorsements, :email
  end
end
