class Journey
  PENALTY_FARE = 5
  COMPLETE_FARE = 1
  attr_reader :entry_station, :completed, :exit_station

  def initialize(station = nil)
    @entry_station = station
    @exit_station =
    @completed = false
  end

  def complete?
    @completed
  end

  def fare
    return PENALTY_FARE if penalty?
    COMPLETE_FARE
  end

  def finish(station = nil)
    @exit_station = station
    @completed = true
    self
  end

  private


  def penalty?
    (!entry_station || !exit_station)
  end

end
