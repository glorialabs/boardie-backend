class CollectionInfo < ApplicationRecord
  scope :active, -> { where(all_time_volume: 100...) }
end
