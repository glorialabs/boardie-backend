class Board < ApplicationRecord
  scope :enabled, -> { where(enabled: true).order(:position) }
  has_many :submissions
  def self.ransackable_attributes(auth_object = nil)
    [ "name", "description", "count", "enabled" ]
  end

  def extra=(value)
    if value.is_a?(String)
      value = JSON.parse(value)
    end
    super(value)
  end
end
