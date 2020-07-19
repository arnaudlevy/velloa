# == Schema Information
#
# Table name: sources
#
#  id         :bigint           not null, primary key
#  image      :text
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
