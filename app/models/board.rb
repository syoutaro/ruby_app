# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class Board < ApplicationRecord
  belongs_to :user, inverse_of: :boards
  has_many :comments, dependent: :delete_all
  has_many :board_tag_relations, dependent: :delete_all
  has_many :tags, through: :board_tag_relations

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
