require "selenium-webdriver"
require 'open-uri'
require 'date'
# require_relative "diccionario_nombres_equipos"

module SmScrapper 
    # def initialize
    #     @driver = Selenium::WebDriver.for :chrome
    # end

    
    def selecionarIdioma(language)
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

    def selecionarDeporte(sport)
        wait = Selenium::WebDriver::Wait.new(timeout: 10)
        wait.until { @driver.find_element(class: 'category_link').displayed? } 

        deportes = @driver.find_elements(class: 'category_link')
        
        for deporte in deportes
            nombreDeporte = deporte.text

            if nombreDeporte == sport
                deporte.click
                return
            end
        end
        
        raise "No se pudo encontrar el deporte " + sport
    end

    def seleccionarCampeonato(campeonato)
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

    def selecionarPais(pais)
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
    
    def cargarPartidos
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
            else
                equipos = fila.text.split("\n")
                nuevoPartido = Partido.new
                nuevoPartido.local = Diccionario.mapeo(equipos[1])[0].valor

                nuevoPartido.visitante = Diccionario.mapeo(equipos[5])[0].valor

                hora = equipos[0].split(":")
                p hora
                nuevoPartido.dividendoLocal = equipos[2].gsub(',', '.')
                nuevoPartido.dividendoEmpate = equipos[4].gsub(',', '.')
                nuevoPartido.dividendoVisitante = equipos[6].gsub(',', '.')

                fechaConstructor = fecha.split(" ")
                nuevoPartido.fecha = ((fechaConstructor[1] +' '+ fechaConstructor[2] + '2019').to_date.to_time + hora[0].to_i.hours + hora[0].to_i.minutes)
                nuevoPartido.fuente = 1
                nuevoPartido.clave = (nuevoPartido.fecha.to_s + nuevoPartido.local.to_s + nuevoPartido.visitante.to_s + nuevoPartido.fuente.to_s)
                oldPartido = Partido.where(clave: nuevoPartido.clave)
                # if oldPartido.empty? 
                    nuevoPartido.save
                # end
            end
        end
    end

    def obtenerPartidosSm()
        @driver = Selenium::WebDriver.for :chrome
        @driver.navigate.to "https://www.supermatch.com.uy/"

        selecionarDeporte("Fútbol")
        selecionarPais("URUGUAY")
        seleccionarCampeonato("Uruguay Clausura")
        cargarPartidos()
        @driver.close
 
    end

end