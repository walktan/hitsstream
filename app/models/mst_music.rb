class MstMusic < ActiveRecord::Base
	has_many :ranks, :dependent :destroy
end
