class BandEvaluator
  def get_band(rating)
    if rating >= 92 then
      band = 'A'
    elsif rating >= 81 then
      band = 'B'
    elsif rating >= 69 then
      band = 'C'
    elsif rating >= 55 then
      band = 'D'
    elsif rating >= 39 then
      band = 'E'
    elsif rating >= 21 then
      band = 'F'
    else
      band = 'G'
    end
    return (band)
  end
end