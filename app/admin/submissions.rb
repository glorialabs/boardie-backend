ActiveAdmin.register Submission do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :address, :ip, :request_details, :board_id, :transaction_hash

  filter :address
  filter :ip
  filter :transaction_hash
  filter :board_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:address, :ip, :request_details, :board_id, :processed]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
