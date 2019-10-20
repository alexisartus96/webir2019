require_relative "../clases/bet365_scrapper"
require_relative "../clases/supermatch_scrapper"

# clase encarga de hacer el scrapping de los partidos disponibles en las distintas casas de apuestas
class Scrapper
    def obtenerPartidosDisponibles
    # debe utilizar los scrappers de bet365 y supermatch para obtener los partidos disponibles en cada una, hacer un merge
    # de las dos listas quedandose con los partidos que estan en ambas casas de apuesta y devolver esa lista.
        bet365 = Bet365Scrapper.new
        supermatch = SupermatchScrapper.new

        partidosBet365 = bet365.obtenerPartidosDisponibles("Uruguay - Clausura")
        partidosSupermatch = supermatch.obtenerPartidosDisponibles("Uruguay - Clausura")
        
        return mergeListaDePartidos(partidosBet365, partidosSupermatch)
    end

    def mergeListaDePartidos(listaPartidos1, listaPartidos2)
    # mergea las 2 lista de partidos, quedandose con los partidos que estan en ambas listas
        partidos = []

        for partido in listaPartidos1
            partidoIn2ndList = getPartidoFromLista(partido, listaPartidos2)

            if partidoIn2ndList
                casaDeApuesta = partidoIn2ndList.dividendos.keys[0]
                dividendos = partidoIn2ndList.dividendos[casaDeApuesta]

                partido.agregarDividendoCasaDeApuesta(casaDeApuesta, dividendos.ganaLocal, dividendos.empate, dividendos.ganaVisitante)
                partidos << partido
            end
        end

        return partidos
    end

    def getPartidoFromLista(partido, listaPartidos)
    # recibe una lista de partidos y, si el partido recibido como parametro esta en la lista, lo devuelve
        for match in listaPartidos
            if match.local == partido.local && match.visitante == partido.visitante
                return match
            end
        end

        return nil
    end
end