require 'open-uri'
require 'date'
require_relative "../clases/bet365_scrapper"

class ObtenerPartidosDisponiblesController < ApplicationController

  def index
      begin
        bet365 = Bet365Scrapper.new
        partidos = bet365.obtenerPartidosDisponibles("Uruguay - Clausura")

        render json: partidos
      rescue OpenURI::HTTPError => ex
        render json: ex
      end 
  end
end