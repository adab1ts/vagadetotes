class AddGroupToEndorsements < ActiveRecord::Migration
  class Endorsement < ActiveRecord::Base
  end
  
  def change
    add_column :endorsements, :group, :boolean
    
    Endorsement.reset_column_information
    reversible do |dir|
      dir.up { Endorsement.update_all group: false }
    end
  end
end
