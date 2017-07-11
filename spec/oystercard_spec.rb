require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }
  let(:station) {double :station}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station}}

  describe '#initialize' do
    it 'has balance of 0' do
      expect(oyster.balance).to eq(0)
    end
  end

  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it 'top up to balance' do
     expect{oyster.top_up 50}.to change {oyster.balance}.from(0).to(50)
   end

   it 'limits balance to 90' do
     maximum_balance = Oystercard::MAXIMUM_BALANCE
     oyster.top_up(maximum_balance)
     expect{oyster.top_up 1}.to raise_error "Maximum limit exceeded £#{maximum_balance}"
   end
 end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(oyster).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should not let me touch in without minimum balance' do
      balance = 0
      expect{oyster.touch_in(station)}.to raise_error 'Not enough balance'
    end

    it 'touches in the card' do
      oyster.top_up(Oystercard::MINIMUM_BALANCE)
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end

    it 'records the entry station' do
      oyster.top_up(Oystercard::MINIMUM_BALANCE)
      oyster.touch_in(station)
      expect(oyster.entry_station).to eq station
    end

  end

  describe '#touch_out' do
    before do
      oyster.top_up(Oystercard::MINIMUM_BALANCE)
      oyster.touch_in(station)
      oyster.touch_out(station)
    end
    it 'touches out the card' do
      expect(oyster).not_to be_in_journey
    end

    it 'reduces the balance by the minimum fare' do
      expect {oyster.touch_out(station)}.to change{oyster.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'forgets the entry station after touch out' do
      #expect(oyster.entry_station).to be_nil
      expect{entry_station.to be_nil}
    end

    it 'records an exit station' do
      expect(oyster.exit_station).to eq station
    end
  end

    it 'starts with an empty list of journeys' do
      expect{ oyster.journeys.to be_empty? }
    end

    before do
      oyster.top_up(Oystercard::MINIMUM_BALANCE)
      oyster.touch_in(entry_station)
      oyster.touch_out(exit_station)
    end

    it 'stores a journey' do
      expect(oyster.journeys).to eq [{entry_station => exit_station}]
    end
end
