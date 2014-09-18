class Endorsement < ActiveRecord::Base
  # will_paginate entries per page
  self.per_page = 50
  
  default_scope { order(:lastname, :name) }
  scope :beginning_with, ->(letter) { where('lastname LIKE ?', "#{letter.upcase}%") }
  scope :individuals,    -> { where(group: false) }
  scope :groups,         -> { where(group: true) }
  scope :subscribed,     -> { where(subscribed: true) }
  scope :hidden,         -> { where(hidden: true) }
  scope :visible,        -> { where(hidden: false) }
  scope :featured,       -> { where(featured: true) }
  scope :approved,       -> { where(approved: true) }
  
  before_validation do |e|
    e.name        = e.name.squish.downcase.scan(/[\d\p{L}\p{P}]+/).map{ |w| %w(i y de del la las lo los).include?(w) ? w : w.capitalize }.join(' ')
    e.email       = e.email.squish.downcase
    e.postal_code = e.postal_code.squish
    e.activity    = e.activity.squish.downcase.capitalize
    
    unless e.group
      e.lastname = e.lastname.squish.downcase.scan(/[\p{L}\p{P}]+/).map{ |w| %w(i y de del la las lo los).include?(w) ? w : w.capitalize }.join(' ')
      e.doctype  = e.doctype.squish.downcase
      e.docid    = e.docid.remove(/[^\da-z]/i).upcase
    end
  end
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }, format: { with: /\A\D+\z/ }, unless: ->(e) { e.group }
  validates :doctype, presence: true, inclusion: { in: %w(dni nie passport) }, unless: ->(e) { e.group }
  validates :docid, presence: true, uniqueness: { case_sensitive: false }, unless: ->(e) { e.group }
  validates :docid, valid_spanish_id: true, if: ->(e) { %w(dni nie).include?(e.doctype) }, unless: ->(e) { e.group }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }, format: { with: /\A([\w\.\+\-]+)@([-\w]+\.)([\w]{2,})\z/ }
  validates :birthdate, presence: true, unless: ->(e) { e.group }
  validates :postal_code, presence: true, format: { with: /\A([1-9]{2}|[0-9][1-9]|[1-9][0-9])[0-9]{3}\z/ }
  validates :activity, length: { maximum: 50 }
  
  before_save do |e|
    e.lastname  = nil if e.lastname.blank?
    e.doctype   = nil if e.doctype.blank?
    e.docid     = nil if e.docid.blank?
    e.birthdate = nil if e.birthdate.blank?
    e.activity  = nil if e.activity.blank?
    e.featured  = 'f'
    e.approved  = 'f'
  end
end
