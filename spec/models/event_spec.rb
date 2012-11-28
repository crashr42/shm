require 'spec_helper'

describe Event do
  context 'should be valid' do
    %w(free busy process close).each do |s|
      it "#{s} event" do
        e = create("#{s}_event".to_sym)
        e.should be_valid
      end
    end
  end

  it 'change status to busy if duration change to 0' do
    e = create(:free_event)
    e.status.should eq('free')
    e.duration.should_not eq(0)
    e.duration = 0
    e.save!
    e.status.should eq('busy')
  end

  it 'change duration to equal difference between date_end and date_start if status change from busy to free' do
    e = create(:busy_event)
    e.status.should eq('busy')
    e.duration.should eq(0)
    e.status = 'free'
    e.save!
    e.status.should eq('free')
    e.duration.should eq((e.date_end - e.date_start).to_i)
  end

  it 'change status to free if duration set greater than 0' do
    e = create(:busy_event)
    e.duration = 2
    e.save!
    e.duration.should eq(2)
    e.status.should eq('free')
  end

  it 'change in the status of priority than change duration' do
    e = create(:free_event)
    e.duration = 2
    e.status = 'busy'
    e.save!
    e.duration.should eq(0)
    e.status.should eq('busy')
  end

  it 'calculate duration for new record' do
    e = build(:free_event)
    e.duration.should eq(nil)
    e.save!
    e.duration.should eq((e.date_end - e.date_start).to_i)
  end

  it 'don\'t calculate duration for saved record' do
    e = create(:free_event)
    new_duration = (e.date_end - e.date_start).to_i + 1
    e.duration = new_duration
    e.save!
    e.duration.should eq(new_duration)
  end

  context 'not available change status from busy' do
    it 'to close' do
      e = create(:busy_event)
      e.status = 'close'
      e.should_not be_valid
    end
  end

  context 'not available change status from process' do
    %w(busy free).each do |s|
      it "to #{s}" do
        e = create(:process_event)
        e.status = s
        e.should_not be_valid
      end
    end
  end

  context 'not available change status from close' do
    %w(process busy free).each do |s|
      it "to #{s}" do
        e = create(:close_event)
        e.status = e
        e.should_not be_valid
      end
    end
  end

  context 'not available change status from free' do
    %w(process close).each do |s|
      it "to #{s}" do
        e = create(:free_event)
        e.status = s
        e.should_not be_valid
      end
    end
  end
end
