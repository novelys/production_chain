class Numeric
  # Rounds to the given decimal position.
  def round_at(d)
    (self * (10.0 ** d)).round.to_f / (10.0 ** d)
  end
end
