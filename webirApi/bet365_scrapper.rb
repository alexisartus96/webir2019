# PARA HACER ANDAR SELENIUM
# - hay q bajarse el jar del server de selenium server desde https://www.seleniumhq.org/download/
# - installar el webdriver de selenium para ruby, gem install selenium-webdriver -v 2.53.4
# - descargar el chromedriver desde https://chromedriver.storage.googleapis.com/index.html?path=2.30/, poner el .exe en la variable PATH
# - ejecutar este archivo, ruby bet365_scrapper.rb
# - creo q no me falto nada

require "selenium-webdriver"

driver = Selenium::WebDriver.for :chrome
driver.navigate.to "https://www.bet365.mx"

wait = Selenium::WebDriver::Wait.new(timeout: 5)
wait.until { driver.find_element(id: 'HeaderWrapper').displayed? }

spanishItem = driver.find_element(id: 'HeaderWrapper').find_elements(tag_name: 'li')[1]
spanishItem.click

wait.until { driver.find_element(class: 'wn-Classification').displayed? } 

footballItem = driver.find_elements(class: 'wn-Classification')[23]
footballItem.click

wait.until { driver.find_element(class: 'sm-CouponLink_Label').displayed? } 

uruguayClausura = driver.find_elements(class: 'sm-CouponLink_Label')[28]
uruguayClausura.click

wait.until { driver.find_element(class: 'sl-MarketCouponFixtureLabelBase').displayed? } 

partidos = driver.find_elements(class: 'sl-CouponParticipantWithBookCloses_Name')

puts ""
puts "Lista de partidos:"
puts ""

for partido in partidos do
    puts partido.text
end

puts ""
