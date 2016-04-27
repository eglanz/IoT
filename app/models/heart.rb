class Heart < ActiveRecord::Base
    validates_presence_of :min
    validates_presence_of :max
    validates_presence_of :average
end
