require 'spec_helper'

T = Class.new(Event) do
  child_events :event, :predicted_time => 15.minutes
end

describe Event do
  it 'default status for event - free' do
    e = create(:event)
    e.status.should eq(:free)
  end

  # Проверяем что события с всеми возможными статусами - являются валидными
  context 'should be valid' do
    %w(free busy process close).each do |s|
      it "#{s} event" do
        e = create("#{s}_event".to_sym)
        e.should be_valid
      end
    end
  end

  # Если продолжительность события сбрасывается на 0 -> статус события должен изменится на busy
  # при этом статус события не меняется явным образом
  it 'change status to busy if duration change to 0' do
    e = create(:free_event)
    e.status.should eq(:free)
    e.duration.should_not eq(0)
    e.duration = 0
    e.save!
    e.status.should eq(:busy)
  end

  # Если событие меняет статус с busy на free -> продолжительность события вычилсяется как разница в секундах 
  # между датой окончания и датой начала события
  it 'change duration to equal difference between date_end and date_start if status change from busy to free' do
    e = create(:busy_event)
    e.status.should eq(:busy)
    e.duration.should eq(0)
    e.status = :free
    e.save!
    e.status.should eq(:free)
    e.duration.should eq((e.date_end - e.date_start).to_i)
  end

  # Если продолжительность события выставляется больше 0 и статус события равен busy ->
  # статус события меняется на free
  it 'change status to free if duration set greater than 0' do
    e = create(:busy_event)
    e.duration = 2
    e.save!
    e.duration.should eq(2)
    e.status.should eq(:free)
  end

  # Изменение статуса приоритетнее чем изменение продолжительности события
  it 'change in the status of priority than change duration' do
    e = create(:free_event)
    e.duration = 2
    e.status = :busy
    e.save!
    e.duration.should eq(0)
    e.status.should eq(:busy)
  end

  # Для новой сущности продолжительность вычисляется автоматически как 
  # разница между датой начала и датой окончания события
  it 'calculate duration for new record' do
    e = build(:free_event)
    e.duration.should eq(nil)
    e.save!
    e.duration.should eq((e.date_end - e.date_start).to_i)
  end

  # Для уже сохраненной сущности продолжительность события не вычилсяется
  it 'don\'t calculate duration for saved record' do
    e = create(:free_event)
    new_duration = (e.date_end - e.date_start).to_i + 1
    e.duration = new_duration
    e.save!
    e.duration.should eq(new_duration)
  end

  # Проверяем создание дочерних событий
  it 'should create child events' do
    d = DateTime.now.at_beginning_of_hour
    e = T.new({
                  :date_start => d,
                  :date_end => d + 2.hours,
                  :description => 'some d',
                  :summary => 'some s'
              })
    e.save!
    e.events.count.should eq(8)
  end

  # Проверяем что
  # изменени статуса для дочернего события с free на busy -> уменьшает продолжительность родительского события
  # изменени статуса для дочернего события с busy на free -> увеличивает продолжительность родительского события
  it 'should subtract parent duration then status change from free to busy' do
    d = DateTime.now.at_beginning_of_hour
    e = T.new({
                  :date_start => d,
                  :date_end => d + 2.hours,
                  :description => 'some d',
                  :summary => 'some s'
              })
    e.save!
    ef = e.events.first

    equal_duration = e.duration - ef.duration
    ef.status = :busy
    ef.save!
    e.reload
    ef.status.should eq(:busy)
    e.duration.should eq(equal_duration)

    equal_duration = e.duration + (ef.date_end - ef.date_start)
    ef.status = :free
    ef.save!
    e.reload
    e.duration.should eq(equal_duration)
  end

  # Проверка изменения статуса события на другие статусы
  context 'not available change status from busy' do
    it 'to close' do
      e = create(:busy_event)
      e.status = :close
      e.should_not be_valid
    end
  end

  context 'not available change status from process' do
    [:busy, :free].each do |s|
      it "to #{s}" do
        e = create(:process_event)
        e.status = s
        e.should_not be_valid
      end
    end
  end

  context 'not available change status from close' do
    [:process, :busy, :free].each do |s|
      it "to #{s}" do
        e = create(:close_event)
        e.status = s
        e.should_not be_valid
      end
    end
  end

  context 'not available change status from free' do
    [:process, :close].each do |s|
      it "to #{s}" do
        e = create(:free_event)
        e.status = s
        e.should_not be_valid
      end
    end
  end
end
