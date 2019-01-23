class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :entry_station
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
      !!entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in!" if @balance < MINIMUM_BALANCE
    @journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @journey = false
    @entry_station = nil
  end
end

private
  def deduct(amount)
    @balance -= amount
  end
