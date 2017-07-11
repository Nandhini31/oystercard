class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance ,:entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
    @exit_station
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum limit exceeded £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance = @balance + amount
  end


  def touch_in(entry_station)
    fail 'Not enough balance' if balance < MINIMUM_BALANCE
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
    @in_journey = false
    @exit_station = exit_station
  end
    def in_journey?
      !!@entry_station
    end

  private

    def deduct(fare)
      @balance = @balance - fare
    end
end
