class Information < ActiveRecord::Base
    validates :day, :date, presence: true
end
