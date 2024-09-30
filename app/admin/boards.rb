ActiveAdmin.register Board do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :count, :enabled, :start_date, :end_date, :position, :extra, :notes, :cover_url

  filter :name
  filter :count
  filter :enabled

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :description
      f.input :count
      f.input :enabled
      f.input :start_date
      f.input :end_date
      f.input :position
      f.input :extra, as: :text, input_html: { rows: 5, value: f.object.extra.to_json }, label: "Extra (JSON)", hint: 'Example: {"uniq_collections": true, "collection_name": "punk", "max_floor_price": 1000, "min_supply": 1000}'
      f.input :notes
      f.input :cover_url
    end
    actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :count, :enabled, :start_date, :position, :extra, :notes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
