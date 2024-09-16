class EventMailer < ApplicationMailer
  def participation(user, event)
    @event = event
    @user = user
    @participation_url = "#{ENV['SITE_DOMAIN']}/admins/events/#{@event.id}/members/join?user_id=#{@user.id}"
    mail subject: "#{@user.name}さんへ　イベントの参加案内", to: user.email
  end
end
