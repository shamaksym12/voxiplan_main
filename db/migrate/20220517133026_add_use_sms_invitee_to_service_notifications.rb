class AddUseSMSInviteeToServiceNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :service_notifications, :use_sms_invitee, :bool
  end
end
