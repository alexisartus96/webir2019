class DividendosPartido
    attr_accessor :ganaLocal, :empate, :ganaVisitante

    def initialize(dividendoLocal, dividendoEmpate, dividendoVisitante)
        @ganaLocal = dividendoLocal
        @empate = dividendoEmpate
        @ganaVisitante = dividendoVisitante
    end
end