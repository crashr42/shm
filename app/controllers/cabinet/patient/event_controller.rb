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
      if @event.unsubsribe current_user.id
        f.html { redirect_to({:controller => :'cabinet/patient/calendar', :action => :index}, :notice => 'You unsubscribe from event.') }
      else
        f.html { redirect_to({:controller => :'cabinet/patient/calendar', :action => :index}, :notice => 'Can\'t unsubscribe from event.') }
      end
    end
  end

  def history
    @offset = params[:offset] || 0
    @limit = params[:limit] || 10
    @history = current_user.events_history.offset(@offset).limit(@limit)

    respond_to do |f|
      f.html { render :text => '' }
      f.json { render :json => @history.reverse.each_with_index.map { |e, i| {
          x: i,
          y: 1,
          name: t("event.type.#{e.type}"),
          id: e.id,
          type: t("event.type.#{e.type}"),
          dateStart: l(e.date_start, :format => :short),
          dateEnd: l(e.date_end, :format => :short)
      } }.to_json.html_safe }
    end
  end

  def documents
    @event = Event.find(params[:id])
  end
end
