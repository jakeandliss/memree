require 'rails_helper'

describe Title do

	context "relationships" do
		it {should belong_to(:user) }
		it {should have_many(:entries) }
	end

end
