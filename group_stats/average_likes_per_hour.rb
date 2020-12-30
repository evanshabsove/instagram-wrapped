require 'json'

class AverageLikesPerHour

  attr_accessor :labels, :data

  def initialize
    @labels = initalize_labels
    @data = initalize_data
  end

  def initalize_labels
    hash = {}
    (0..23).each do |i|
      hash[i.to_s] = "#{i+1}:00"
    end
    hash
  end

  def initalize_data
    hash = {}
    (0..23).each do |i|
      hash[i.to_s] = 0
    end
    hash
  end

  def set_data
    total_shares = 0
    file = File.read('../messages/message_1.json')
    data_hash = JSON.parse(file)
    data_hash['messages'].each do |message|
      next unless message['type'] == 'Share'
      next if message['reactions'].nil?

      total_shares += 1

      sec = (message['timestamp_ms'].to_f / 1000)
      time = Time.at(sec)
      hour = time.hour.to_s


      @data[hour] += message['reactions'].length
    end
  end

end

avg_likes = AverageLikesPerHour.new
avg_likes.set_data
puts avg_likes.data
