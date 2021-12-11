# == Schema Information
#
# Table name: organisations
#
#  id          :integer          not null, primary key
#  hourly_rate :decimal(, )      not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Organisation < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :hourly_rate
end
