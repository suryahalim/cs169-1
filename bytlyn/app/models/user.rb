class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :waitlist
  validates :name, presence: true   
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png",
  					:storage => :s3,
  					:bucket => 'bytlyn-development',
					:s3_credentials => {
					:access_key_id => ENV['AKIAIHGCOC2OKKBGB7NQ'],
					:bucket => ENV['bytlyn-development'],
					:secret_access_key => ENV['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']
				}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
