class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :waitlist
  validates :name, presence: true

  has_attached_file :avatar, :styles => {:original =>"", :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png",
  					:storage => :s3,
  					:bucket => 'bytlyn-development',
					:s3_credentials => {
					:access_key_id => ENV['AKIAISMBCST6IB77XTBA'],
					:bucket => ENV['bytlyn-development'],
					:secret_access_key => ENV['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']
				}
  validates_attachment :avatar,
  content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
  size: { less_than: 5.megabytes}
  # Users.errors.delete(:avatar)

  def has_payment_info?
    braintree_customer_id
  end

end
