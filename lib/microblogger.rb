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
      printf "Enter command: t,q,dm:  "
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
      else
        puts "Sorry, don't know that command"
      end
    end
  end

  def tweet(message)
   @client.update(message)
  end
  
  def dm(target, message)
    puts "Sending #{target} this direct message:"
    puts message
    message = "d @#{target} #{message}"
    tweet(message)
  end
end

blogger = MicroBlogger.new
blogger.run
