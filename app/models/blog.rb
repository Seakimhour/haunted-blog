# frozen_string_literal: true

class Blog < ApplicationRecord
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :liking_users, class_name: 'User', source: :user, through: :likings

  validates :title, :content, presence: true

  validate :random_eyecatch_can_only_access_by_primium_user

  scope :published, -> { where('secret = FALSE') }

  scope :search, lambda { |term|
    where('title LIKE :term OR content LIKE :term', term: "%#{term}%")
  }

  scope :default_order, -> { order(id: :desc) }

  def owned_by?(target_user)
    user == target_user
  end

  private

  def random_eyecatch_can_only_access_by_primium_user
    return unless random_eyecatch == true && !user.premium?

    errors.add(:random_eyecatch, 'プレミアム ユーザーのみがこの機能を使用できます。')
  end
end
