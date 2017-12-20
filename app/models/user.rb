class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum: 50 }
    validates :email, presence: true
    validates :password, length: { minimum: 6 }, :on=>:create
    validates :password_confirmation, presence: true, :on=>:create
    has_secure_password
    has_many :attrecords, dependent: :destroy
    has_many :corrective, dependent: :destroy
    has_many :ato, dependent: :destroy
    has_many :miss, dependent: :destroy

    after_initialize :init
    before_save :downcase_email

    def init
        #if self.<property> is nil then set to value
        self.certLevel ||= 1
        self.employee ||= 000000
        self.role ||= 1
        self.team ||= 0 
        #todo Initate a new attrecord for user? 
    end
    def downcase_email
        self.email = email.downcase
    end
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost

        BCrypt::Password.create(string, cost: cost)
    end
    
      # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
    end
    
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
end
