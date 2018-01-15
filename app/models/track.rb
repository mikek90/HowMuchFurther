class Track < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :latitude_from, :length => { :minimum => 3}, format: { with: /[0-9]{1,2}.[0-9]+/, message: "Only format similar is: 11.22222" }
  validates :longtitude_from, :length => { :minimum => 3}, format: { with: /[0-9]{1,2}.[0-9]+/, message: "Only format similar is: 11.22222" }
  validates :latitude_to, :length => { :minimum => 3}, format: { with: /[0-9]{1,2}.[0-9]+/, message: "Only format similar is: 11.22222" }
  validates :longtitude_to, :length => { :minimum => 3}, format: { with: /[0-9]{1,2}.[0-9]+/, message: "Only format similar is: 11.22222" }
end
