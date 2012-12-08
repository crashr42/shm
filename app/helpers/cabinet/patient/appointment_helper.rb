module Cabinet::Patient::AppointmentHelper
  def link_to_prev(id, date)
    if @date - 1.day >= DateTime.now.to_date
      link_to 'Previouse', link_to_path, link_to_attributes(id, date - 1.day)
    end
  end

  def link_to_next(id, date)
    link_to 'Next', link_to_path, link_to_attributes(id, date + 1.day)
  end

  private
  def link_to_path
    {:controller => :'cabinet/patient/appointment', :action => :find}
  end

  def link_to_attributes(id, date)
    {:class => 'jump-day', :'data-date' => date.to_time.to_i, :'data-id' => id}
  end
end
