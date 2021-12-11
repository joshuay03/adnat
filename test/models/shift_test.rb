# == Schema Information
#
# Table name: shifts
#
#  id           :integer          not null, primary key
#  break_length :integer          default(0), not null
#  finish       :datetime         not null
#  start        :datetime         not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#
require "test_helper"

class ShiftTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
