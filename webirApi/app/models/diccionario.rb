class Diccionario < ApplicationRecord

  scope :mapeo, ->(nombre) { where('clave == ?', nombre) if nombre.present? }
end
