require 'json'

class TotalReactions

  attr_accessor :total_reactions

  def initialize
    @total_reactions = 0
  end

  def count_total_reactions
    @memes_shared = 0
    file = File.read('../messages/message_1.json')
    data_hash = JSON.parse(file)
    data_hash['messages'].each do |message|
      next unless message['type'] == 'Share' || !message['photos'].nil?
      next if message['reactions'].nil?

      sec = (message['timestamp_ms'].to_f / 1000)
      time = Time.at(sec)
      next if time.year != 2020

      @total_reactions += message['reactions'].length
    end
  end

end


total_reactions = TotalReactions.new
total_reactions.count_total_reactions
puts total_reactions.total_reactions
