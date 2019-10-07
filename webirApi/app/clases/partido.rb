class Partido
    attr_accessor :local, :visitante

    def initialize(local, visitante)
        @local = local
        @visitante = visitante
    end
end