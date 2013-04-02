# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#


class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end

##  Note that by default all model attributes are accessible
##  The statement attr_accessible makes it so that
##  ONLY the listed attributes are availalb to outside users

##  Acitve record allows you to individually assign attributes
##  just like a normal Class using
##     .email = "some_email_address"
## 
##  It also provides methods including 
##     .save
##     .reload.email    <-resets the object stored in memory
##                        to match the database entry
##     .all      <-Returns array describing all objects
##     .update_attributes(:name => "Name", :email => "Email")
##                        ^<- accepts a hash of any accessible
##                            attributes. updates and saves 
##                            in one step
