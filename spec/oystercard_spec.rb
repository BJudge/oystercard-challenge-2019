require 'oystercard'
describe Oystercard do
  let(:station){ double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'should have a balance of £0' do
      expect(subject.balance).to eq 0
  end

  it 'has an empty list of journeys by deault' do
    expect(subject.journeys).to be_empty
  end

  #it 'stores a journey' do
  #  subject.top_up(1)
  #  subject.touch_in(entry_station)
  #  expect(subject.journeys).to include journey
  #end


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
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it 'will not touch_in if below minimum balance' do
    expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in!"
  end

  describe "#touch_out" do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
      it "can touch_out" do
        subject.top_up(1)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it 'stores exit station' do
        subject.top_up(1)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end
  end


  it 'reduces balance by the MINIMUM_BALANCE when you touch_out' do
    subject.top_up(1)
    subject.touch_in(station)
    expect {subject.touch_out(station)}.to change{subject.balance}.by -Oystercard::MINIMUM_BALANCE
  end

  it 'stores the entry station' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
end
