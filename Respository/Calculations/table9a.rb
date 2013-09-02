require "mscorlib"
require "System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"

class Table9a

  def initialize()
  end

  def Lookup(h, g, te, hlp, ti, tmp)
    tau = tmp / (3.6 * hlp)
    a = 1.0 + (tau / 15.0)
    l = h * (ti - te)
    gamma = g / l
    if gamma <= 0.0 then
      eta = 1.0
    elsif gamma == 1.0 then
      eta = a / (a + 1.0)
    else
      eta = (1.0 - Math.Pow(gamma, a)) / (1.0 - Math.Pow(gamma, (a + 1.0)))
    end
    return (self.Result9a(l, tau, eta))
  end

end