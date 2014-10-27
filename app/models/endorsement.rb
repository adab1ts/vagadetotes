class Endorsement < ActiveRecord::Base
  # will_paginate entries per page
  self.per_page = 50
  
  default_scope { order(:lastname, :name) }
  scope :beginning_with, ->(letter) { where('lastname LIKE ?', "#{letter.upcase}%") }
  scope :individuals,    -> { where(group: false) }
  scope :groups,         -> { where(group: true) }
  scope :subscribed,     -> { where(subscribed: true) }
  scope :not_subscribed, -> { where(subscribed: false) }
  scope :hidden,         -> { where(hidden: true) }
  scope :visible,        -> { where(hidden: false) }
  scope :featured,       -> { where(featured: true) }
  scope :approved,       -> { where(approved: true) }
  scope :rejected,       -> { where(approved: false) }
  
  before_validation do |e|
    e.email       = e.email.squish.downcase
    e.postal_code = e.postal_code.squish
    e.activity    = e.activity.squish.capitalize
    
    unless e.group
      e.name     = e.name.squish.capitalize.scan(/[\d\p{L}\p{P}]+/).map{ |w| w =~ /\A(i|y|de|del|la|las|lo|los)\z/i ? w : w.capitalize }.join(' ')
      e.lastname = e.lastname.squish.downcase.scan(/[\p{L}\p{P}]+/).map{ |w| w =~ /\A(i|y|de|del|la|las|lo|los)\z/i ? w : w.capitalize }.join(' ')
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
  
  before_create do |e|
    if e.group
      e.lastname  = e.name
      e.doctype   = nil
      e.docid     = nil
      e.birthdate = nil
    end
    e.activity  = nil if e.activity.blank?
    e.featured  = 'f'
    e.approved  = 'f'
  end
  
  def full_name
    self.group ? self.name : "#{name} #{lastname}"
  end
end
