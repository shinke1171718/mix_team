class Admins::HomesController < Admins::BaseController
  def index
    @tab_param = params[:tab] || '1'
    events_grouped = Event.active.ordered_desc.includes(members: :user).group_by(&:state)
    @entry_events = Kaminari.paginate_array(events_grouped["entry"] || []).page(params[:entry_page]).per(5)
    @closed_events = Kaminari.paginate_array(events_grouped["closed"] || []).page(params[:closed_page]).per(5)
  end
end
