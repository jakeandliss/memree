require 'rails_helper'

describe Image do

	context "relationships" do
		it {should belong_to(:imageable) }
	end

end
