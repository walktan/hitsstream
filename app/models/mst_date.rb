class MstDate < ActiveRecord::Base
	has_many :ranks, :dependent :destroy
end
