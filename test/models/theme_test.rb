# == Schema Information
#
# Table name: themes
#
#  id         :bigint           not null, primary key
#  keywords   :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
