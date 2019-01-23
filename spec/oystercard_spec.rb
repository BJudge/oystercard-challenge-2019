require 'oystercard'
describe Oystercard do
  it 'should have a balance of £0' do
      expect(subject.balance).to eq 0
  end
  it 'should be able to top_up' do
    expect{subject.top_up 5}.to change {subject.balance}.by 5
  end
end
