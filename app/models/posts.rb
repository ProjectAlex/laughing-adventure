class Posts < ActiveRecord::Base
has_many :comments
def post_params
		params.permit(:foo, :bar)
	end
end
