class ChangeExpiredColumnInRoleRecord < ActiveRecord::Migration
  def up

    rename_column :role_records, :expired_date, :expired_date_old
    add_column :role_records, :expire_date, :text
    
    RoleRecord.reset_column_information
    
    RoleRecord.find(:all).each do |role_record| 
        role_record.update_attribute(:expire_date,
                                    RoleRecord.expired_date_old) 
    end
    
    remove_column :role_records, :expired_date_old


  end

  def down
  end
end
