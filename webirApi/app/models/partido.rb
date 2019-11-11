class Partido < ApplicationRecord

  scope :partido_valido, ->(time) { where('fecha > ?', time) if time.present? }
end
