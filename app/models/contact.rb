class Contact < ActiveRecord::Base
    validates :name, presence: true
    validates :email, presence: true
    validates :contact, presence: true
end
