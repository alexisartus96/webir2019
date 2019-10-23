

class PartidoController < ApplicationController
  def index
      # scrapper = Scrapper.new
      # partidos = scrapper.obtenerPartidosDisponibles()

      partidos = Partido.all

      render json: partidos
  end

  def create
    # obtenerPartidosBet365("México - Torneo Apertura")
    obtenerPartidosSm()
  end
end
