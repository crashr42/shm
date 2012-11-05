class Cabinet::Patient::EventController < Cabinet::PatientController
  def index
    start_date = Time.at(params[:start].to_i).to_date
    end_date = Time.at(params[:end].to_i).to_date

    respond_to do |f|
      f.json {
        events = Event.find_by_user_and_date current_user.id, start_date, end_date

        render :json => events.map {|e|{
            id:    e.id,
            title: e.category,
            start: e.date_start,
            end:   e.date_end
        }}
      }
    end
  end

  def show
    @event = Event.find params[:id]

    respond_to do |format|
      format.html
      format.json { render :json => @event }
    end
  end
end
