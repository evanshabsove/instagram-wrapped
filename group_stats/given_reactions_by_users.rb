require 'json'

class GivenReactionsByUsers

  attr_accessor :users

  def initialize
    @users = {
      ryan: 0,
      adam: 0,
      harry: 0,
      julien: 0,
      schustr001: 0,
      jacob: 0,
      scott: 0,
      kai: 0,
      evan: 0
    }
  end

  def count_reactions_by_users
    @memes_shared = 0
    file = File.read('../messages/message_1.json')
    data_hash = JSON.parse(file)
    data_hash['messages'].each do |message|
      next unless message['type'] == 'Share' || !message['photos'].nil?
      next if message['reactions'].nil?

      sec = (message['timestamp_ms'].to_f / 1000)
      time = Time.at(sec)
      next if time.year != 2020

      message['reactions'].each do |reaction|
        user_first_name = reaction['actor'].split(' ').first.downcase.to_sym
        @users[user_first_name] += 1
      end
    end
  end

end


reactions_by_users = GivenReactionsByUsers.new
reactions_by_users.count_reactions_by_users
puts reactions_by_users.users
