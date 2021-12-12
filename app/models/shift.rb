# == Schema Information
#
# Table name: shifts
#
#  id              :integer          not null, primary key
#  break_length    :integer          default(0), not null
#  finish          :datetime         not null
#  start           :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organisation_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_shifts_on_organisation_id  (organisation_id)
#  index_shifts_on_user_id          (user_id)
#
# Foreign Keys
#
#  organisation_id  (organisation_id => organisations.id)
#
class Shift < ApplicationRecord
  belongs_to :organisation
  belongs_to :user

  validates :start, presence: true
  validates :finish, presence: true
  validates :organisation_id, presence: true
  validates :user_id, presence: true

  def date
    'test'
  end

  def start_time
    ''
  end

  def finish_time
    ''
  end

  def hours_worked
    ''
  end

  def cost
    ''
  end
end
