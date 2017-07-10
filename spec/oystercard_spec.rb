require 'oystercard'


describe Oystercard do

  subject(:oyster) { described_class.new }

  it 'has balance of 0' do
    expect(oyster.balance).to eq(0)
  end

  describe '#top_up' do

    it {is_expected.to respond_to(:top_up).with(1).argument}

    it 'top up to balance' do
     expect{oyster.top_up 50}.to change {oyster.balance}.from(0).to(50)
   end
  end
end
