require_relative "../clases/scrapper"

class ObtenerPartidosDisponiblesController < ApplicationController

  def index
    begin
      # scrapper = Scrapper.new
      # partidos = scrapper.obtenerPartidosDisponibles()

      partidos = Partido.partido_valido

      render json: partidos
    rescue OpenURI::HTTPError => ex
      render json: ex
    end 
  end

  def create
    cargar_partidos()
  end
end