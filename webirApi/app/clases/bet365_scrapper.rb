require "selenium-webdriver"
require_relative "partido"
require_relative "diccionario_nombres_equipos"

class Bet365Scrapper 
    def initialize
        @driver = Selenium::WebDriver.for :chrome
    end

    def selecionarIdioma(language)
        wait = Selenium::WebDriver::Wait.new(timeout: 5)
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

    def selecionarDeporte(sport)
        wait = Selenium::WebDriver::Wait.new(timeout: 5)
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

    def selecionarCampeonato(campeonato)
        wait = Selenium::WebDriver::Wait.new(timeout: 5)
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
    
    def getListaDePartidos
        listaPartidos = []
        wait = Selenium::WebDriver::Wait.new(timeout: 5)
        wait.until { @driver.find_element(class: 'sl-MarketCouponFixtureLabelBase').displayed? } 

        columnaPartidos = @driver.find_element(class: 'sl-MarketCouponFixtureLabelBase')
        columnasDividendos = @driver.find_elements(class: 'sl-MarketCouponValuesExplicit33')

        columnaDividendosLocal = columnasDividendos[0]
        columnaDividendosEmpate = columnasDividendos[1]
        columnaDividendosVisitante = columnasDividendos[2]

        dividendosLocales = columnaDividendosLocal.find_elements(class: 'gll-ParticipantOddsOnly_Odds')
        dividendosEmpates = columnaDividendosEmpate.find_elements(class: 'gll-ParticipantOddsOnly_Odds')
        dividendosVisitantes = columnaDividendosVisitante.find_elements(class: 'gll-ParticipantOddsOnly_Odds')

        partidos = columnaPartidos.find_elements(class: 'sl-CouponParticipantWithBookCloses_Name')

        partidos.each_with_index do |partido, index|
            equipos = partido.text.split(" v ")
            local = getNombreUnificado(equipos[0])
            visitante = getNombreUnificado(equipos[1])

            dividendoLocal = dividendosLocales[index].text
            dividendoEmpate = dividendosEmpates[index].text
            dividendoVisitante = dividendosVisitantes[index].text

            nuevoPartido = Partido.new(local, visitante, 'FECHA', 'HORA')
            nuevoPartido.agregarDividendoCasaDeApuesta('bet365', dividendoLocal, dividendoEmpate, dividendoVisitante)

            listaPartidos << nuevoPartido
        end

        return listaPartidos
    end

    def obtenerPartidosDisponibles(liga)
        @driver.navigate.to "https://www.bet365.mx"

        selecionarIdioma("Español")
        selecionarDeporte("Fútbol")
        selecionarCampeonato(liga)

        partidos = getListaDePartidos
        @driver.close

        return partidos 
    end
end