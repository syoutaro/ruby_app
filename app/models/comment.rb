# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_board_id  (board_id)
#  index_comments_on_user_id   (user_id)
#

class Comment < ApplicationRecord
  belongs_to :board
  belongs_to :user

  validates :comment, presence: true, length: { maximum: 1000 }
end
