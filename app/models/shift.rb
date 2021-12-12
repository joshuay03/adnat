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
    return '' unless self.start.present?
    self.start.strftime("%d/%m/%Y")
  end

  def start_time
    return '' unless self.start.present?
    self.start.strftime("%I:%M %p")
  end

  def finish_time
    return '' unless self.finish.present?
    self.finish.strftime("%I:%M %p")
  end

  def hours_worked
    return '' unless self.start.present? && self.finish.present?
    minutes_to_hours(
      ((self.finish.hour * 60) + (self.finish.min)) -
      ((self.start.hour * 60) + (self.start.min)) -
      (self.break_length)
    ).round(2)
  end

  def cost
    return '' unless self.hours_worked.present?
    "$#{hours_worked * hourly_rate}"
  end

  private

  def minutes_to_hours(mnts)
    hrs = 0.0
    while mnts > 0 do
      if mnts > 60
        hrs += 1.0
        mnts -= 60
      else
        hrs += mnts / 60.0
        mnts = 0
      end
    end
    hrs
  end

  def hourly_rate
    Organisation.find_by(id: self.organisation_id).hourly_rate
  end
end
