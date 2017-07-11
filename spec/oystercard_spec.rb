require 'oystercard'

describe Oystercard do

  subject(:oyster) { described_class.new }

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

  describe '#deduct' do
    it 'deducts balance' do
      expect{oyster.deduct(1)}.to change {oyster.balance}.by -1
    end
  end


end


#
