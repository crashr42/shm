class Cabinet::Manager::RecurrenceController < Cabinet::ManagerController

  layout 'cabinet/manager/layout'

  def new
    if request.post?
      rule = RecurrenceRule.new params[:rule]
      rule.save!

      redirect_to :controller => :recurrence, :action => :new
    end
  end

  def find
    @events = Event.where('summary like ?', "%#{params[:name]}%").limit(10)

    render :layout => false
  end

  def show
    @rule = RecurrenceRule.find params[:id]
  end

  def edit
    @rule = RecurrenceRule.find params[:id]
  end
end
