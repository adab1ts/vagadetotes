class Endorsement < ActiveRecord::Base
  default_scope { order(lastname: :asc) }
  scope :beginning_with, ->(letter) { where('lastname LIKE ?', "#{letter.upcase}%") }
  scope :subscribed,    -> { where(subscribed: true) }
  scope :hidden,        -> { where(hidden: true) }
  scope :visible,       -> { where(hidden: false) }
  scope :featured,      -> { where(featured: true) }
  
  before_validation do |e|
    e.name        = e.name.squish.downcase.titleize
    e.lastname    = e.lastname.squish.downcase.titleize
    e.docid       = e.docid.squish.upcase
    e.email       = e.email.squish.downcase
    e.postal_code = e.postal_code.squish
    e.activity    = e.activity.squish.downcase.titleize
  end
  
  validates :name, presence: true, length: { maximum: 25 }, format: { with: /\A([a-z]+\s?)+\z/i }
  validates :lastname, presence: true, length: { maximum: 25 }, format: { with: /\A([a-z]+\s?)+\z/i }
  validates :doctype, presence: true, inclusion: { in: %w(dni nie passport) }
  validates :docid, presence: true, uniqueness: { case_sensitive: false }
  validates :docid, valid_spanish_id: true, unless: ->(e) { e.doctype == 'passport' }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([\w\.\+\-]+)@([-\w]+\.)([\w]{2,})\z/i }
  validates :birthdate, presence: true
  validates :postal_code, presence: true, format: { with: /\A([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}\z/ }
  validates :activity, length: { maximum: 25 }, format: { with: /\A([a-z]+\s?)*\z/i }
  
  before_create do |e|
    e.activity = nil if e.activity.blank?
    e.featured = false
  end
end
