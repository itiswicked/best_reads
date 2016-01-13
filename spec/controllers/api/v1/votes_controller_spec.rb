# require "rails_helper"
#
# RSpec.describe Api::V1::VotesController, type: :controller do
#   describe "POST /api/v1/votes" do
#     it "creates a new upvote" do
#       upvote = build(:upvote)
#       post :create_upvote, upvote: upvote.attributes
#       expect(response).to have_http_status(:created)
#       expect(response.header["Location"]).to match /\/api\/v1\/votes/
#     end
#
#     it "creates a new downvote" do
#       downvote = build(:downvote)
#       post :create_downvote, downvote: downvote.attributes
#       expect(response).to have_http_status(:created)
#       expect(response.header["Location"]).to match /\/api\/v1\/votes/
#     end
#
#     it "returns 'not_found' if validations fail" do
#       post :create_upvote, upvote: { user_id: 0, review_id: 0 }
#       expect(response).to have_http_status(:not_found)
#     end
#   end
# end
