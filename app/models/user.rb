# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :languages
  has_many :flashcards

  validates :name, presence: true, uniqueness: true, length: { maximum: 24 }

  paginates_per 5

  ratyrate_rater

  mount_uploader :avatar, AvatarUploader
end
