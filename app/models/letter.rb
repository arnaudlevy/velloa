# == Schema Information
#
# Table name: letters
#
#  id          :bigint           not null, primary key
#  ending_at   :date
#  starting_at :date
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Letter < ApplicationRecord
end
