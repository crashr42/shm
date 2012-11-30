require 'spec_helper'

describe Bid do
  before { BidMailer.deliveries.clear }

  it 'should be valid' do
    b = build(:bid)
    b.should be_valid
  end

  it 'should send email after created' do
    b = create(:bid)
    BidMailer.deliveries.count.should eq(1)
    BidMailer.deliveries.last.to.should eq([b.email])
  end

  it 'should rejected' do
    b = create(:bid)
    BidMailer.deliveries.clear
    b.reject
    BidMailer.deliveries.count.should eq(1)
    BidMailer.deliveries.last.to.should eq([b.email])
    b.status.should eq('rejected')
  end

  it 'should approved' do
    b = create(:bid)
    BidMailer.deliveries.clear
    Role.stub(:find_by_name).with('patient').and_return(create(:patient_role))
    b.approve
    BidMailer.deliveries.count.should eq(1)
    BidMailer.deliveries.last.to.should eq([b.email])
    b.status.should eq('approved')
  end
end
