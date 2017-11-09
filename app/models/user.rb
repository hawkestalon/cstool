class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum: 50 }
    validates :email, presence: true
    validates :password, length: { minimum: 6 }, :on=>:create
    validates :password_confirmation, presence: true, :on=>:create
    has_secure_password
    has_many :attrecords, dependent: :destroy
    has_many :corrective, dependent: :destroy
    has_many :ato, dependent: :destroy

    after_initialize :init

    def init
        #if self.<property> is nil then set to value
        self.certLevel ||= 1
        self.employee ||= 000000
        self.role ||= 1
        self.team ||= 0 
    end
end
