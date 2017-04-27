class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
               :omniauthable, :omniauth_providers => [:github]

 def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.save
    end
 end

 def self.new_with_session(params, session)
 	super.tap do |user|
 		if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
 			user.email = data["email"] if user.email.blank?
 		end
 	end
 end
  has_many :resumes
  def admin?
     is_admin
  end
end
