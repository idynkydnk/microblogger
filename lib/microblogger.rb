require 'twitter'

class MicroBlogger
	attr_reader :client

	def initialize
		puts "Initializing..."
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "o3RUfh8TOSyCx0KyAZW3dm0QP"
      config.consumer_secret     = "dB5lQb0FPngYBIeHWvbKgNHpXTCbPwrsfMaXU5cPqFXxflvBqG"
      config.access_token        = "797996804268769280-GhsN0bET1pCWusxSg5v0CIRcFNz3HRa"
      config.access_token_secret = "n0CxT5QQTHLipv6wOLcmwy1YhZ70us9nMK94PxkWsBF3d"
    end
	end
  
  def run
    puts "Welcome to Kyle's Twitter Client!"
    command = ""
    while command != "q"
      printf "Enter command: t,q,dm,spam,elt:  "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      case command
      when 'q' then puts "Goodbye!"
      when 't'
        if parts[1] && parts[1..-1].join(" ").length < 140 
          tweet(parts[1..-1].join(" "))
          puts "You tweeted!"
        else
          puts "Enter a tweet after the letter 't' or maybe you just entered more than 140 characters"
        end
      when 'dm' then dm(parts[1], parts[2..-1].join(" "))
      when 'spam' then spam_my_followers(parts[1..-1].join(" "))
      when 'elt' then everyones_last_tweet
      else
        puts "Sorry, don't know that command"
      end
    end
  end

  def tweet(message)
   @client.update(message)
  end
  
  def dm(target, message)
    screen_names = @client.followers.collect { |follower|
      @client.user(follower).screen_name }
    if screen_names.include?(target)
      puts "Sending #{target} this direct message:"
      puts message
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "You're not even friends with that user!"
    end
  end

  def followers_list
    screen_names = []
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    return screen_names
  end
  
  def spam_my_followers(message)
    followers_list.each do |follower|
      dm(follower, message)
    end
  end

  def everyones_last_tweet
    friends = @client.friends.sort_by { |friend| friend.screen_name.downcase}
    friends.each do |friend|
      timestamp = friend.status.created_at
      puts friend.screen_name + " tweeted this on " + 
        timestamp.strftime("%A, %b %d")
      puts friend.status.full_text
      puts
      puts
    end
  end
end

blogger = MicroBlogger.new
blogger.run
