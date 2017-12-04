ActiveAdmin.register Port do
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
  permit_params :switch_id, :port, :remark, :speed

  form do |f| f.inputs 'Port detail' do
      f.input :switch_id, as: :select, collection: Switch.all.map { |s| [s.name, s.id] }
      f.input :port
      f.input :speed
      f.input :remark
    end
    f.actions
  end

end
