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
class Theme < ApplicationRecord
  has_and_belongs_to_many :articles

  default_scope { order(:name) }

  def to_s
    "#{name}"
  end
end
