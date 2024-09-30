class Submission < ApplicationRecord
  scope :minted, -> { where.not(transaction_hash: nil) }

  validates :address, presence: true, length: { minimum: 3, maximum: 66 }
  validates_each :address, :transaction_hash do |record, attr, value|
    record.errors.add(attr, "must start with 0x") if value.present? && !value.start_with?("0x")
  end
  validates :board_id, presence: true
  belongs_to :board, counter_cache: true

  def self.ransackable_attributes(auth_object = nil)
    [ "address", "ip", "transaction_hash", "board_id" ]
  end
end
