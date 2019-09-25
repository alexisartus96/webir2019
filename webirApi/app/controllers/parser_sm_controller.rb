require 'open-uri'
require 'date'
class ParserSmController < ApplicationController

  def index
      begin
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
        render json: @entriesArray
      rescue OpenURI::HTTPError => ex
        render json: ex
      end 
  end
end