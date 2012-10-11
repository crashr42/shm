class Cabinet::Manager::CalendarController < Cabinet::ManagerController

  layout 'cabinet/manager/layout'

  def index
    if params[:date].present?
      @date = DateTime.parse(params[:date]).to_date
    else
      @date = DateTime.now.to_date
    end
    @events = Event.where(:calendar_id => params[:id]).where('date(date_start) = ?', @date)
  end
end
