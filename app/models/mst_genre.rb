class MstGenre < ActiveRecord::Base
	has_many :ranks, :dependent :destroy
end
