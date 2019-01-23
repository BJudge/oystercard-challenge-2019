require 'oystercard'
describe Oystercard do
  it 'should have a balance of £0' do
      expect(subject.balance).to eq 0
  end
  describe "#top_up" do
    it 'should be able to top_up' do
      expect{subject.top_up 5}.to change {subject.balance}.by 5
    end
    it 'should have a limit of £90' do
      subject.top_up(5)
      expect{subject.top_up(86)}.to raise_error "cannot exceed balance of #{Oystercard::MAXIMUM_BALANCE}"
    end
  end
  
  it 'is initially not in a journey' do
    expect(subject).not_to be_in_journey
  end
  it "can touch_in" do
    subject.top_up(1)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'will not touch_in if below minimum balance' do
    expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in!"
  end

  it "can touch_out" do
    subject.top_up(1)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'reduces balance by the MINIMUM_BALANCE when you touch_out' do
    subject.top_up(1)
    subject.touch_in
    expect {subject.touch_out}.to change{subject.balance}.by -Oystercard::MINIMUM_BALANCE
  end
end
