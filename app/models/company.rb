class Company < ActiveRecord::Base
  set_primary_key "id"
  include UUIDHelper
  attr_accessible :address, :name, :id_number1, :city, :state, :country, :telephone, :fax, :zip_code, :email, :web, :contact, :plan, :date_format, :decimal_format, :unit, :separator, :delimiter, :logo
 
 # validates :name, presence: true

  PLANS = ["GRATIS","PAGO"]
  validates :plan, inclusion: PLANS
  
  has_many :users, :foreign_key => 'domain'
  has_many :products, :foreign_key => 'domain'
  has_many :brands, :foreign_key => 'domain'
  has_many :categories, :foreign_key => 'domain'
  has_many :accounts, :foreign_key => 'domain'
  has_many :document_types, :foreign_key => 'domain'
  has_many :stocks, :foreign_key => 'domain'
  has_many :documents, :foreign_key => 'domain'
  has_many :document_lines, :foreign_key => 'domain'
  has_many :payments, :foreign_key => 'domain'
  has_many :payments_documents, :foreign_key => 'domain'
  
has_attached_file :logo, styles: {
    thumb: '100x100>',
    square: '500x200>',
    medium: '300x300>'
  }, :url => '/:class/:attachment/:id/:style_:basename.:extension'

# Validate content type
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

end
