class Cabinet::Manager::CalendarController < Cabinet::ManagerController

  layout 'cabinet/manager/layout'

  def index
    @year = params[:year].present? ? params[:year].to_i : DateTime.now.year
    @month = params[:month].present? ? params[:month].to_i : DateTime.now.month
    @from_date = Date.parse("#@year-#@month-01")
    @to_date = Date.civil @year, @month, -1
    @previous_month = @month - 1 < 1 ? 12 : @month - 1
    @previous_year = @month - 1 < 1 ? @year - 1 : @year
    @next_month = @month + 1 > 12 ? 1 : @month + 1
    @next_year = @month + 1 > 12 ? @year + 1 : @year
    @calendar_date_from = @from_date.at_beginning_of_week
    @calendar_date_to = @to_date.at_end_of_week

    @events = Event.includes(:attendees).where(:attendees => {:user_id => params[:id]}).where('date(date_start) < ?', @to_date).where('date(date_start) > ?', @from_date)
  end
end
