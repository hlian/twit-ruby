require "data_mapper"
require "sinatra"

DataMapper.setup(:default, "sqlite3::memory:")

class Tweet
  include DataMapper::Resource
  property :id, Serial
  property :tweet, String
end

Tweet.auto_migrate!
first = Tweet.new
first.tweet = "here's an example tweet"
first.save

get "/" do
  @tweets = Tweet.all
  erb :index
end

post "/api/tweets" do
  tweet = Tweet.new
  tweet.tweet = imgify(params[:tweet])
  tweet.save!
  redirect to("/")
end

# Given the tweet string, returns an HTML version with the image URLs
# marked up into fancy <img> tags

# Example:
#  'this.  https://media.giphy.com/media/xQ6pVAYjUfMDC/giphy.gif'
#  =>
#  'this.  <img src="https://media.giphy.com/media/xQ6pVAYjUfMDC/giphy.gif" />"'
def imgify(tweet)
  return tweet
end

# Example images
# --------------
# https://media.giphy.com/media/xQ6pVAYjUfMDC/giphy.gif
# https://pbs.twimg.com/media/CtzmqH6VYAAvaSB.jpg
# https://pbs.twimg.com/media/CsqklZMWAAAlGCg.jpg
