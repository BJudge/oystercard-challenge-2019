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
  describe "#deduct" do
    it 'should be able to deduct from balance' do
      subject.top_up(10)
      expect{subject.deduct(5)}.to change {subject.balance}.by -5
    end
  end
end
