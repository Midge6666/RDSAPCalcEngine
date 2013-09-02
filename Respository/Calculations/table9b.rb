class Table9b
  def initialize()
  end

  def Lookup(tau, t_off, th, r, g, h, te, eta)
    tc = 4.0 + (0.25 * tau)
    tsc = ((1.0 - r) * (th - 2.0)) + (r * (te + (eta * g / h)))
    if t_off <= tc then
      u = 0.5 * self.SQR(t_off) * (th - tsc) / (24.0 * tc)
    else
      u = (tTh - tsc) * (t_off - (0.5 * tc)) / 24.0
    end
    return (u)
  end

end