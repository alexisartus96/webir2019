class Partido
    attr_accessor :local, :visitante, :dividendoLocal, :dividendoEmpate, :dividendoVisitante

    def initialize(local, visitante, dividendoLocal, dividendoEmpate, dividendoVisitante)
        @local = local
        @visitante = visitante
        @dividendoLocal = dividendoLocal
        @dividendoEmpate = dividendoEmpate
        @dividendoVisitante = dividendoVisitante
    end
end