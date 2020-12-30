require 'json'

class TotalMemesShared

  attr_accessor :memes_shared

  def initialize
    @memes_shared = 0
  end

  def count_total_memes_shared
    @memes_shared = 0
    file = File.read('../messages/message_1.json')
    data_hash = JSON.parse(file)
    data_hash['messages'].each do |message|
      next unless message['type'] == 'Share' || !message['photos'].nil?

      sec = (message['timestamp_ms'].to_f / 1000)
      time = Time.at(sec)
      next if time.year != 2020

      @memes_shared += 1
    end
  end

end

total_memes_shared = TotalMemesShared.new
total_memes_shared.count_total_memes_shared
puts total_memes_shared.memes_shared
