ActiveAdmin.register AdminUser do
  config.sort_order = 'id_asc'
  config.filters = false
  config.batch_actions = false
  
  permit_params :email, :password, :password_confirmation

  index download_links: false do
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
