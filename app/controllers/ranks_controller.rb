class RanksController < ApplicationController

	def index
		@ranks = Rank.all
	end

end
