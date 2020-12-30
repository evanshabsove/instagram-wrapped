require 'json'
require 'pry'

class PostsWithMaxLikes

  attr_accessor :messages_with_max_likes

  def initialize
    @messages_with_max_likes = []
  end

  def count_posts_with_max_likes
    @memes_shared = 0
    file = File.read('../messages/message_1.json')
    data_hash = JSON.parse(file)
    data_hash['messages'].each do |message|
      next unless message['type'] == 'Share' || !message['photos'].nil?
      next if message['reactions'].nil?

      sec = (message['timestamp_ms'].to_f / 1000)
      time = Time.at(sec)
      next if time.year != 2020
      next if message['reactions'].length < 7

      binding.pry
      @messages_with_max_likes << message
    end
  end

end


total_memes_shared = PostsWithMaxLikes.new
total_memes_shared.count_posts_with_max_likes
puts total_memes_shared.messages_with_max_likes
