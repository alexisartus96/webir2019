# app/controllers/application_controller.rb
require 'bet365_scrapper'
require 'sm_scrapper'
require 'params_utils'

class ApplicationController < ActionController::API
  include Response
  include Bet365Scrapper
  include SmScrapper
 


  rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message }, :not_found)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    json_response({ message: e.message }, :unprocessable_entity)
  end
end