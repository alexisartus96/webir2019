require_relative "../clases/scrapper"

class ObtenerPartidosDisponiblesController < ApplicationController

  def index
      begin
        scrapper = Scrapper.new
        partidos = scrapper.obtenerPartidosDisponibles()

        render json: partidos
      rescue OpenURI::HTTPError => ex
        render json: ex
      end 
  end
end