require "selenium-webdriver"
require 'date'

module SmScrapper 

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
                unless(Diccionario.mapeo(equipos[1]).empty?)
                    local = Diccionario.mapeo(equipos[1])[0].valor
                end
                unless(Diccionario.mapeo(equipos[5]).empty?)
                    visitante = Diccionario.mapeo(equipos[5])[0].valor
                end

                hora = equipos[0].split(":")
                dividendoLocal = equipos[2].gsub(',', '.')
                dividendoEmpate = equipos[4].gsub(',', '.')
                dividendoVisitante = equipos[6].gsub(',', '.')

                fechaString = fecha.split(" ")
                fechaConstructor = (fechaString[1] +' '+ fechaString[2] + '2019').to_date
                
                fechaPartido = DateTime.new(2019, fechaConstructor.month, fechaConstructor.day, hora[0].to_i, hora[1].to_i)
                clave = (local.to_s + visitante.to_s + fechaPartido.year.to_s + fechaPartido.month.to_s + fechaPartido.day.to_s)
                partidoClave = Partido.where(clave: clave)
                if partidoClave.empty?
                    p "Nuevo partido Supermatch #{local} vs #{visitante} #{fechaPartido}"
                    nuevoPartido = Partido.new
                    nuevoPartido.local = local
                    nuevoPartido.visitante = visitante
                    nuevoPartido.fecha = fechaPartido
                    nuevoPartido.dividendoEmpateSM = dividendoEmpate
                    nuevoPartido.dividendoLocalSM = dividendoLocal
                    nuevoPartido.dividendoVisitanteSM = dividendoVisitante
                    nuevoPartido.clave = clave 
                    nuevoPartido.save
                else
                    p "Update partido Supermatch #{local} vs #{visitante} #{fechaPartido}"
                    oldPartido = partidoClave[0]
                    oldPartido.update(:dividendoEmpateSM => dividendoEmpate,
                                        :dividendoLocalSM => dividendoLocal,
                                        :dividendoVisitanteSM => dividendoVisitante)
                end
            end
        end
    end

    def obtenerPartidosSm()
        options = Selenium::WebDriver::Chrome::Options.new
        #esta linea sirve para que no te levante el navegador
        options.add_argument('--headless')
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        @driver = Selenium::WebDriver.for(:chrome, options: options)
        @driver.navigate.to "https://www.supermatch.com.uy/"

        selecionarDeporteSM("Fútbol", 'category_link')
        selecionarPaisSM("ARGENTINA")
        seleccionarCampeonatoSM("Argentina 1ª")
        cargarPartidosSM()
        @driver.close
 
    end

end