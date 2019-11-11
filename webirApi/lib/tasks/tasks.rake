

require 'bet365_scrapper'
require 'sm_scrapper'
include SmScrapper
include Bet365Scrapper

namespace :tasks do
  desc "TODO"
  task carga_partidos: :environment do
    obtenerPartidosSm()
    obtenerPartidosBet365()
  end

end
