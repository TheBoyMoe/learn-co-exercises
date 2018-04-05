ActiveAdmin.register Author do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  
ActiveAdmin.register Author do
  # set up strong params so only name and genre can be set
  permit_params :name, :genre

  # By default all CRUD actions are available
  # limit CRUD actions on resource to 'all', except 'destroy'
  # removes the 'delete' link from the admin panel
  actions :all, except: [:destroy]

  # amend the default form, removing the 'bio' field(since we're only allowing name and genre
  form do |f|
    inputs 'Author' do
      f.input :name
      f.input :genre
    end
    f.semantic_errors
    f.actions
  end
end

end
