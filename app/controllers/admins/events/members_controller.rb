class Admins::Events::MembersController < Admins::BaseController
  skip_before_action :authenticate_admin!, only: [:show, :join]

  def show
    @event = Event.find params[:event_id]
    @member = @event.members.find(params[:id])
  end

  def join
    @event = Event.find_by(id: params[:event_id])
    @user = User.find_by(id: params[:user_id])
    return redirect_to admins_join_error_path unless @event && @user

    @member = Member.find_by(event: @event, user: @user)
    return redirect_to admins_event_member_path(@event, @member) if @member

    @member = Member.new(event: @event, user: @user)

    if @member.save
      redirect_to admins_event_member_path(@event, @member)
    else
      redirect_to admins_join_error_path
    end
  end

  def join_error; end

  def resend
    @event = Event.find params[:event_id]
    @user = User.find params[:id]
    EventMailer.participation(@user, @event).deliver_later

    redirect_to admins_event_path(@event), notice: 'イベント案内を再送しました。'
  end
end
