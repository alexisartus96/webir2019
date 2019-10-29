
require "selenium-webdriver"
class PartidoController < ApplicationController
  def index
      # scrapper = Scrapper.new
      # partidos = scrapper.obtenerPartidosDisponibles()
      # partidos = Diccionario.all
      partidos = Partido.all

      render json: partidos
  end

  def create
    obtenerPartidosBet365("Argentina - Superliga")
    obtenerPartidosSm()
  end

end
