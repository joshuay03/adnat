# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string           not null
#  name            :string           not null
#  password        :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organisation_id :integer
#
# Indexes
#
#  index_users_on_organisation_id  (organisation_id)
#
class User < ApplicationRecord
  has_many :shifts, through: :organisation

  validates :name, presence: true
  validates :email_address, presence: true
  validates :password, presence: true, :length => { :minimum => 6 }

  def authenticate(password)
    self.errors.add(:password, 'incorrect') unless self.password == password
    self
  end
end
