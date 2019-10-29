require "selenium-webdriver"
require 'open-uri'
require 'date'
# require_relative "diccionario_nombres_equipos"

module SmScrapper 
    # def initialize
    #     @driver = Selenium::WebDriver.for :chrome
    # end

    def selecionarDeporteSM(sport, search_class)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { @driver.find_element(class: search_class).displayed? } 

        deportes = @driver.find_elements(class: search_class)
        
        for deporte in deportes
            nombreDeporte = deporte.text

            if nombreDeporte == sport
                deporte.click
                return
            end
        end
        
        raise "No se pudo encontrar el deporte " + sport
    end

    def seleccionarCampeonatoSM(campeonato)
        ligas = @driver.find_elements(class: 'championships')
        for liga in ligas
            nombreLiga = liga.text

            if nombreLiga == campeonato
                liga.click
                return
            end
        end

        raise "No se pudo encontrar el campeonato '" + campeonato + "'"
    end

    def selecionarPaisSM(pais)
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(class: 'leaguehead').displayed? } 
        wait.until { @driver.find_element(class: 'main-bet').displayed? }

        paises = @driver.find_elements(class: 'leaguehead')

        for paisAux in paises
            nombrePais = paisAux.text

            if nombrePais == pais
                paisAux.click
                return
            end
        end

        raise "No se pudo encontrar el campeonato '" + pais + "'"
    end
    
    def cargarPartidosSM
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(class: 'main-content-bet-wrapper').displayed? }
        sleep(3)

        columnaPartidos = @driver.find_element(class: 'main-content-bet-wrapper')

        filaPartido = columnaPartidos.find_elements(:xpath => "./*")
        fecha = nil


        filaPartido.each_with_index do |fila, index|
            clasesFila = fila.attribute("class")

            if clasesFila.include? 'date'
                fecha = fila.text
            elsif clasesFila.include? 'clearfix' 
                equipos = fila.text.split("\n")
                local = equipos[1]
                visitante = equipos[5]
                p "##################"
                p Diccionario.mapeo(equipos[1])
                unless(Diccionario.mapeo(equipos[1]).empty?)
                    local = Diccionario.mapeo(equipos[1])[0].valor
                    p "##################"
                    p local
                end
                unless(Diccionario.mapeo(equipos[1]).empty?)
                    visitante = Diccionario.mapeo(equipos[5])[0].valor
                end

                hora = equipos[0].split(":")
                dividendoLocal = equipos[2].gsub(',', '.')
                dividendoEmpate = equipos[4].gsub(',', '.')
                dividendoVisitante = equipos[6].gsub(',', '.')

                fechaString = fecha.split(" ")
                fechaConstructor = (fechaString[1] +' '+ fechaString[2] + '2019').to_date
                
                fechaPartido = DateTime.new(2019, fechaConstructor.month, fechaConstructor.day, hora[0].to_i, hora[1].to_i)
                # p fechaPartido
                clave = (fechaPartido.to_s + local.to_s + visitante.to_s)
                partidoClave = Partido.where(clave: clave)
                if partidoClave.empty?
                    nuevoPartido = Partido.new
                    nuevoPartido.local = local
                    nuevoPartido.visitante = visitante
                    # p "###################################"
                    # p fechaPartido
                    nuevoPartido.fecha = fechaPartido
                    nuevoPartido.dividendoEmpateSM = dividendoEmpate
                    nuevoPartido.dividendoLocalSM = dividendoLocal
                    nuevoPartido.dividendoVisitanteSM = dividendoVisitante
                    nuevoPartido.clave = clave 
                    nuevoPartido.save
                else
                    oldPartido = partidoClave[0]
                    oldPartido.update(:dividendoEmpateSM => dividendoEmpate,
                                        :dividendoLocalSM => dividendoLocal,
                                        :dividendoVisitanteSM => dividendoVisitante)
                end
            end
        end
    end

    def obtenerPartidosSm()
        @driver = Selenium::WebDriver.for :chrome
        @driver.navigate.to "https://www.supermatch.com.uy/"

        selecionarDeporteSM("Fútbol", 'category_link')
        selecionarPaisSM("ARGENTINA")
        seleccionarCampeonatoSM("Argentina 1ª")
        cargarPartidosSM()
        @driver.close
 
    end

end