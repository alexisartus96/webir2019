require "selenium-webdriver"
# require_relative "diccionario_nombres_equipos"

module Bet365Scrapper 
    # def initialize
    #     @driver = Selenium::WebDriver.for :chrome
    # end

    
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
                p equipos
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
                p "###################################"
                p fechaPartido
                fechaPartido = fechaPartido + 2.hours
                p "###################################"
                p fechaPartido
                clave = (fechaPartido.to_s + local.to_s + visitante.to_s)
                partidoClave = Partido.where(clave: clave)
                if partidoClave.empty?
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
                    oldPartido = partidoClave[0]
                    oldPartido.update(:dividendoEmpateBet => dividendoEmpate,
                                        :dividendoLocalBet => dividendoLocal,
                                        :dividendoVisitanteBet => dividendoVisitante)
                end
            end
        end
    end

    def obtenerPartidosBet365(liga)
        @driver = Selenium::WebDriver.for :chrome
        @driver.navigate.to "https://www.bet365.mx"

        selecionarIdiomaBet("Español")
        selecionarDeporteBet("Fútbol")
        selecionarCampeonatoBet(liga)
        cargarPartidosBet()
        @driver.close
 
    end
end