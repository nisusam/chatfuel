class Site < ApplicationRecord
  has_many :tracks, dependent: :destroy
end
