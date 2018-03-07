# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date
#  color       :string
#  name        :string           not null
#  sex         :string(1)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


class Cat < ApplicationRecord
  COLORS = ['black', 'green', 'calico']

  validates :birth_date, presence: :true
  validates :color, inclusion: { in: COLORS }
  validates :name, presence: true
  validates :sex, inclusion: { in: %w(M F) }

  has_many :cat_rental_requests,
  dependent: :destroy,
  foreign_key: :cat_id

  def age
    "#{Time.now.year - birth_date.year} years old"
  end
end
