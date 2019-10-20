require_relative "dividendos_partido"

class Partido
    attr_accessor :local, :visitante, :fecha, :hora, :dividendos

    def initialize(local, visitante, fecha, hora)
        @local = local
        @visitante = visitante
        @fecha = fecha
        @hora = hora
        @dividendos = {}
    end

    def agregarDividendoCasaDeApuesta(casaDeApuesta, dividendoLocal, dividendoEmpate, dividendosVisitante)
    # agrega los dividendos de una casa de apuesta
        dividendos = DividendosPartido.new(dividendoLocal, dividendoEmpate, dividendosVisitante)
        @dividendos[casaDeApuesta] = dividendos
    end
end