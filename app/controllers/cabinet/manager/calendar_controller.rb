class Cabinet::Manager::CalendarController < Cabinet::ManagerController
  layout 'cabinet/manager/layout'

  def index
    @user = User.find params[:id]
    gon.id = params[:id]
  end

  def events
    @events = Event.includes(:attendees).where(:attendees => {:user_id => params[:id]}).where('date(date_start) between ? and ?', Time.at(params[:start].to_i).to_date, Time.at(params[:end].to_i).to_date)

    render :json => @events.map {|e|{
        id:    e.id,
        title: e.category,
        start: e.date_start,
        end:   e.date_end
    }}
  end
end
