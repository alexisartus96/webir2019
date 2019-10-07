# PARA HACER ANDAR SELENIUM
# - hay q bajarse el jar del server de selenium server desde https://www.seleniumhq.org/download/
# - installar el webdriver de selenium para ruby, gem install selenium-webdriver -v 2.53.4
# - descargar el chromedriver desde https://chromedriver.storage.googleapis.com/index.html?path=2.30/, poner el .exe en la variable PATH
# - ejecutar este archivo, ruby bet365_scrapper.rb
# - creo q no me falto nada

require "selenium-webdriver"
require_relative "partido"

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
        wait.until { @driver.find_element(class: 'sm-CouponLink_Label').displayed? } 

        ligas = @driver.find_elements(class: 'sm-CouponLink_Label')

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

        partidos = @driver.find_elements(class: 'sl-CouponParticipantWithBookCloses_Name')

        for partido in partidos do
            equipos = partido.text.split(" v ")
            local = equipos[0]
            visitante = equipos[1]

            listaPartidos << Partido.new(local, visitante)
        end

        return listaPartidos
    end

    def obtenerPartidosDisponibles(liga)
        @driver.navigate.to "https://www.bet365.mx"

        selecionarIdioma("Español")
        selecionarDeporte("Fútbol")
        selecionarCampeonato(liga)

        return getListaDePartidos
    end
end

scrapper = Bet365Scrapper.new
partidos = scrapper.obtenerPartidosDisponibles("Argentina - Nacional B")

puts ""
puts "Lista de partidos:"
puts ""

for partido in partidos do
    puts partido.local + " VS " + partido.visitante
end

puts ""
