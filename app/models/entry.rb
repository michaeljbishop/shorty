class Entry < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validate :valid_url?, on: :create

  def valid_url?
    URI(url)
  rescue URI::InvalidURIError
    errors.add(:url, "is not valid")
  end
end
