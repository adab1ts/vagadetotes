ActiveAdmin.register Endorsement do
  config.sort_order = 'id_asc'
  
  actions :all, except: [:new, :create, :show]
  
  permit_params do
    params = [
      :name,
      :lastname,
      :doctype,
      :docid,
      :email,
      :birthdate,
      :postal_code,
      :activity,
      :subscribed,
      :hidden,
      :group,
      :featured,
      :approved
    ]
    params
  end
  
  batch_action :feature, priority: 1, confirm: I18n.t('active_admin.batch_actions.default_confirmation') do |ids|
    Endorsement.find(ids).each do |e|
      e.update(featured: true)
    end
    redirect_to collection_path, notice: I18n.t('active_admin.batch_actions.default_success')
  end
  
  batch_action :destroy, priority: 10, confirm: I18n.t('active_admin.batch_actions.default_confirmation') do |ids|
    Endorsement.find(ids).each do |e|
      e.destroy
    end
    redirect_to collection_path, notice: I18n.t('active_admin.batch_actions.default_success')
  end
  
  batch_action :approve, priority: 100, confirm: I18n.t('active_admin.batch_actions.default_confirmation') do |ids|
    Endorsement.find(ids).each do |e|
      e.update(approved: true)
    end
    redirect_to collection_path, notice: I18n.t('active_admin.batch_actions.default_success')
  end
  
  scope "Persones", :individuals
  scope "Grups", :groups
  scope "Visibles", :visible
  scope "No visibles", :hidden
  scope "Validades", :approved
  scope "No validades", :rejected
  scope "Subscrites", :subscribed
  scope "No subscrites", :not_subscribed
  scope "Destacades", :featured
  
  index do
    selectable_column
    id_column
    column :full_name, sortable: [:lastname, :name]
    column :doctype
    column :docid
    column :email
    column :birthdate
    column :postal_code
    column :activity
    column :group
    column :subscribed
    column :hidden
    column :featured
    column :approved
    actions
  end
  
  filter :lastname
  filter :doctype, as: :select
  filter :postal_code
  filter :birthdate
  filter :subscribed

  csv do
    column :id
    column :full_name
    column :doctype
    column :docid
    column :email
    column :birthdate
    column :postal_code
    column :activity
    column :group
    column :subscribed
    column :hidden
    column :featured
    column :approved
  end
end
