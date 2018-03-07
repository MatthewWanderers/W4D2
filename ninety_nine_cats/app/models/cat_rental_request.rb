# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :does_not_overlap_approved_requests

  belongs_to :cat,
  foreign_key: :cat_id

  def overlapping_requests
    prev_reqs = CatRentalRequest.where(cat_id: cat_id)
    prev_reqs.each do |req|
      prev_range = (req.start_date..req.end_date)
      current_range = (start_date..end_date)
       if (prev_range.cover?(start_date) ||
      prev_range.cover?(end_date) ||
      current_range.cover?(req.start_date) ||
      current_range.cover?(req.end_date))
        errors.add(:current_range, "Dates can't overlap with previous request")
      else
        true
      end
  end

  def does_not_overlap_approved_requests
    !overlapping_requests
  end

end
