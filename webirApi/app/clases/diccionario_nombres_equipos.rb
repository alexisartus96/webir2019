class Equipo
    attr_accessor :posibles_nombres, :nombre_unificado

    def initialize(posiblesNombres, nombreUnificado)
        @posibles_nombres = posiblesNombres
        @nombre_unificado = nombreUnificado
    end
end

$equiposUruguay = []

$equiposUruguay << Equipo.new(["Peñarol"], "Peñarol")
$equiposUruguay << Equipo.new(["Nacional"], "Nacional")
$equiposUruguay << Equipo.new(["Defensor Sporting", "Defensor Sp."], "Defensor SP")
$equiposUruguay << Equipo.new(["Juventud", "Juventud De Las Piedras"], "Juventud de las piedas")
$equiposUruguay << Equipo.new(["Boston River"], "Boston River")
$equiposUruguay << Equipo.new(["Cerro Largo"], "Cerro largo")
$equiposUruguay << Equipo.new(["Cerro"], "Cerro")
$equiposUruguay << Equipo.new(["CA River Plate", "River Plate (Uru)"], "River")
$equiposUruguay << Equipo.new(["Rampla Juniors"], "Rampla")
$equiposUruguay << Equipo.new(["Danubio"], "Danubio")
$equiposUruguay << Equipo.new(["Fenix"], "Fenix")
$equiposUruguay << Equipo.new(["Progreso"], "Progreso")
$equiposUruguay << Equipo.new(["Plaza Colonia"], "Plaza Colonia")
$equiposUruguay << Equipo.new(["Racing (Uru)", "Racing Club de Montevideo"], "Racing")
$equiposUruguay << Equipo.new(["Montevideo Wanderers", "Wanderers (Uru)"], "Wanderers")
$equiposUruguay << Equipo.new(["Liverpool (Uru)", "Liverpool Montevideo"], "Liverpool")

def getNombreUnificado(nombreEquipo)
# devuelve el nombre unificado de un equipo
    for equipo in $equiposUruguay
        if equipo.posibles_nombres.include? nombreEquipo
            return equipo.nombre_unificado
        end
    end

    return nil
end