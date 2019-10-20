require_relative "partido"
require 'open-uri'
require 'date'

=begin
date = (Time.now.to_time.to_i)
url= "https://www.supermatch.com.uy/home_preview_center?_=" + date.to_s
doc = Nokogiri::HTML(open(url).read) 
entries = doc.css('div.clearfix.main-bet.row')
@entriesArray = []
entries.each do |entry|
    hora = entry.css('span.time').text.tr(" \t\r\n", '')
    left_option = entry.css('a.left.option_l').css('span.identifier.text-ellipsis').text
    right_option = entry.css('a.right.option_r').css('span.identifier.text-ellipsis').text
    paga = entry.css('a.middle').text.tr(" \t\r\n", '')
    element = {hora:hora, left_option:left_option,paga:paga , right_option:right_option}
    @entriesArray << element
end
=end

class SupermatchScrapper 
    
    def obtenerPartidosDisponibles(liga)
    # debe devolver un array de objetos partidos con los partidos disponibles en supermatch
    # TODO, por ahora, devuelve una lista atornillada
        partidos = []

        partido1 = Partido.new("CA River Plate", "Cerro Largo", 'FECHA', 'HORA')
        partido1.agregarDividendoCasaDeApuesta('supermatch', "1.65", "3.23", "2.60")
        
        partido2 = Partido.new("Defensor Sporting", "Racing Club de Montevideo", 'FECHA', 'HORA')
        partido2.agregarDividendoCasaDeApuesta('supermatch', "1.33", "2.93", "3.10")
        
        partido3 = Partido.new("Juventud De Las Piedras", "Liverpool Montevideo", 'FECHA', 'HORA')
        partido3.agregarDividendoCasaDeApuesta('supermatch', "2.55", "3.03", "1.60")

        partidos << partido1
        partidos << partido2
        partidos << partido3

        return partidos
    end
end