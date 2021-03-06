class Cabinet::Patient::EventController < Cabinet::PatientController
  def index
    start_date = Time.at(params[:start].to_i).to_date
    end_date = Time.at(params[:end].to_i).to_date

    respond_to do |f|
      f.json {
        events = Event.find_by_user_and_date current_user.id, start_date, end_date

        render :json => events.map { |e| {
            id: e.id,
            title: t("event.type.#{e.type}"),
            className: e.status_to_css,
            start: e.date_start,
            end: e.date_end
        } }
      }
    end
  end

  def show
    @event = Event.find params[:id]

    respond_to do |format|
      format.html {}
      format.json { render :json => @event }
    end
  end

  def unsubscribe
    @event = Event.find params[:id]
    respond_to do |f|
      if @event.unsubsribe(current_user.id)
        f.html { redirect_to({:controller => :'cabinet/patient/calendar', :action => :index}, :notice => 'You unsubscribe from event.') }
      else
        f.html { redirect_to({:controller => :'cabinet/patient/calendar', :action => :index}, :notice => 'Can\'t unsubscribe from event.') }
      end
    end
  end

  def info
    @event = Event.find params[:id]

    respond_to do |f|
      f.html
      f.json { render :json => @event }
    end
  end
end
