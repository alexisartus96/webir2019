$equiposUruguay = []

$equiposUruguay << Equipo.new(["Peñarol"], "Peñarol")
$equiposUruguay << Equipo.new(["Nacional (Uru)", "Nacional De Football"], "Nacional")
$equiposUruguay << Equipo.new(["Defensor Sporting", "Defensor Sp."], "Defensor SP")
$equiposUruguay << Equipo.new(["Juventud", "Juventud De Las Piedras"], "Juventud de las piedas")
$equiposUruguay << Equipo.new(["Boston River"], "Boston River")
$equiposUruguay << Equipo.new(["Cerro Largo"], "Cerro largo")
$equiposUruguay << Equipo.new(["Cerro"], "Cerro")
$equiposUruguay << Equipo.new(["CA River Plate", "River Plate (Uru)"], "River")
$equiposUruguay << Equipo.new(["Rampla Juniors"], "Rampla")
$equiposUruguay << Equipo.new(["Danubio"], "Danubio")
$equiposUruguay << Equipo.new(["Fénix", "Centro Atlético Fénix"], "Fenix")
$equiposUruguay << Equipo.new(["Progreso", "Club Atletico Progreso"], "Progreso")
$equiposUruguay << Equipo.new(["Plaza Colonia"], "Plaza Colonia")
$equiposUruguay << Equipo.new(["Racing (Uru)", "Racing Club de Montevideo"], "Racing")
$equiposUruguay << Equipo.new(["Montevideo Wanderers", "Wanderers (Uru)"], "Wanderers")
$equiposUruguay << Equipo.new(["Liverpool (Uru)", "Liverpool Montevideo"], "Liverpool")

module Diccionario

def getNombreUnificado(nombreEquipo)
# devuelve el nombre unificado de un equipo
    for equipo in $equiposUruguay
        if equipo.posibles_nombres.include? nombreEquipo
            return equipo.nombre_unificado
        end
    end

    return nil
end

end