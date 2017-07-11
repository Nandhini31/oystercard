class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(amount)
    fail "Maximum limit exceeded £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    @balance = @balance + amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end


  def in_journey?
    @status
  end

  def touch_in
    @status = true
  end

  def touch_out
    @status = false 
  end
end
