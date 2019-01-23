class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance
  attr_accessor :journey

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    fail "cannot exceed balance of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance =+ amount
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def in_journey?
    @journey
  end
  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end
end
