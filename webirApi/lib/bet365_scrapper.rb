require "selenium-webdriver"

module Bet365Scrapper 
    
    def selecionarIdiomaBet(language)
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(id: 'HeaderWrapper').displayed? }

        idiomas = @driver.find_element(id: 'HeaderWrapper').find_elements(tag_name: 'li')
        
        for idioma in idiomas
            nombreIdioma = idioma.text

            if nombreIdioma == language
                idioma.click
                return
            end
        end
        
        raise "No se pudo encontrar el idioma " + idioma
    end

    def selecionarDeporteBet(sport)
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(class: 'wn-Classification').displayed? } 

        deportes = @driver.find_elements(class: 'wn-Classification')
        
        for deporte in deportes
            nombreDeporte = deporte.text

            if nombreDeporte == sport
                deporte.click
                return
            end
        end
        
        raise "No se pudo encontrar el deporte " + sport
    end

    def selecionarCampeonatoBet(campeonato)
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(class: 'slm-CouponLink_Label').displayed? } 

        ligas = @driver.find_elements(class: 'slm-CouponLink_Label')

        for liga in ligas
            nombreLiga = liga.text

            if nombreLiga == campeonato
                liga.click
                return
            end
        end

        raise "No se pudo encontrar el campeonato '" + campeonato + "'"
    end
    
    def cargarPartidosBet
        wait = Selenium::WebDriver::Wait.new(timeout: 15)
        wait.until { @driver.find_element(class: 'sl-MarketCouponFixtureLabelBase').displayed? } 
        sleep(3)

        columnaPartidos = @driver.find_element(class: 'sl-MarketCouponFixtureLabelBase')
        columnasDividendos = @driver.find_elements(class: 'sl-MarketCouponValuesExplicit33')

        columnaDividendosLocal = columnasDividendos[0]
        columnaDividendosEmpate = columnasDividendos[1]
        columnaDividendosVisitante = columnasDividendos[2]

        dividendosLocales = columnaDividendosLocal.find_elements(:xpath => "./*")
        dividendosEmpates = columnaDividendosEmpate.find_elements(:xpath => "./*")
        dividendosVisitantes = columnaDividendosVisitante.find_elements(:xpath => "./*")

        filaPartido = columnaPartidos.find_elements(:xpath => "./*")
        fecha = nil

        filaPartido.each_with_index do |fila, index|
            clasesFila = fila.attribute("class")

            if clasesFila.include? 'gll-MarketColumnHeader'
                fecha = fila.text
            elsif not clasesFila.include? 'sl-CouponParticipantWithBookCloses_ClockPaddingLeft'
                nuevoPartido = Partido.new
                nombresEquipos = fila.find_element(class: 'sl-CouponParticipantWithBookCloses_Name')
                hora = fila.find_element(class: 'sl-CouponParticipantWithBookCloses_LeftSideContainer').text.split(":")

                equipos = nombresEquipos.text.split(" v ")
                local = equipos[0]
                visitante = equipos[1]
                unless(Diccionario.mapeo(equipos[0]).empty?)
                    local = Diccionario.mapeo(equipos[0])[0].valor
                end
                unless(Diccionario.mapeo(equipos[1]).empty?)
                    visitante = Diccionario.mapeo(equipos[1])[0].valor
                end

                dividendoLocal = dividendosLocales[index].text
                dividendoEmpate = dividendosEmpates[index].text
                dividendoVisitante = dividendosVisitantes[index].text
                fechaConstructor = (fecha).to_date
                
                fechaPartido = DateTime.new(2019, fechaConstructor.month, fechaConstructor.day, hora[0].to_i, hora[1].to_i)
                fechaPartido = fechaPartido + 2.hours
                clave = (local.to_s + visitante.to_s + fechaPartido.year.to_s + fechaPartido.month.to_s + fechaPartido.day.to_s)
                partidoClave = Partido.where(clave: clave)
                if partidoClave.empty?
                    p "Nuevo partido Bet365 #{local} vs #{visitante} #{fechaPartido}"
                    nuevoPartido = Partido.new
                    nuevoPartido.local = local
                    nuevoPartido.visitante = visitante
                    nuevoPartido.fecha = fechaPartido
                    nuevoPartido.dividendoEmpateBet = dividendoEmpate
                    nuevoPartido.dividendoLocalBet = dividendoLocal
                    nuevoPartido.dividendoVisitanteBet = dividendoVisitante
                    nuevoPartido.clave = clave 
                    nuevoPartido.save
                else
                    p "Update Bet365 partido #{local} vs #{visitante} #{fechaPartido}"
                    oldPartido = partidoClave[0]
                    oldPartido.update(:dividendoEmpateBet => dividendoEmpate,
                                        :dividendoLocalBet => dividendoLocal,
                                        :dividendoVisitanteBet => dividendoVisitante)
                end
            end
        end
    end

    def obtenerPartidosBet365()
        options = Selenium::WebDriver::Chrome::Options.new
        #esta linea sirve para que no te levante el navegador
        options.add_argument('--headless')
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        @driver = Selenium::WebDriver.for(:chrome, options: options)
        @driver.navigate.to "https://www.bet365.mx"

        selecionarIdiomaBet("Español")
        selecionarDeporteBet("Fútbol")
        selecionarCampeonatoBet("Argentina - Superliga")
        cargarPartidosBet()
        @driver.close
 
    end
end