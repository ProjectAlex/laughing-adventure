class Posts < ActiveRecord::Base
def post_params
		params.permit(:foo, :bar)
	end
end
