class Step < ApplicationRecord
  belongs_to :message
  has_one :track, dependent: :destroy

  validates :act, uniqueness: { scope: :message_id }

  def value
    track.try(:code) || super
  end
end
