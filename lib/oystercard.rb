class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
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

  def in_journey?
    @journey
  end
  def touch_in
    fail "Insufficient balance to touch in!" if @balance < MINIMUM_BALANCE
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @journey = false
  end
end

private
  def deduct(amount)
    @balance = @balance - amount
  end
