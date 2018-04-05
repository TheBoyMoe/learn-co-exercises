ActiveAdmin.register Song do
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

  ActiveAdmin.register Song do
    # you can't edit/create a song until strong params are set
    # you can still delete
    # by default all actions are enabled
    permit_params :title, :artist_name
  end
end
