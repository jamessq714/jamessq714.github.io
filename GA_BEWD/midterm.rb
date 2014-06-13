# Your assignment: create a command line based application (similar to Secret Number) 
# that fulfills the following criteria:

# Takes user input and handles bad input appropriately
# (i.e. if you expect numbers and recieve a string)
# Connects to a 3rd party API - the API call should change depending on the user input
# Must be object oriented. Create classes and instantiate them. 
# The only file that can run without classes is your runner.
# Create a public repository and push your file code on Github. 
# Please submit the link to your repository for this assignment.
# This is a very open-ended assignment. 
# Feel free to get creative! If there are any special features of your application 
# that you would like to point out, please write about them in the README.

require "rubygems"
require "twilio-ruby"
require 'pry'

account_sid =  'AC0fb531876178fe787e028a7e0e44fcf0'
auth_token = '7a35e04a9c69ae1643875a97ea8eec24'
text = "Hello, this is a text from James"
from = "+15105747104"

puts "Hello, what is your phone number?"

phoneNum = gets.chomp

while (phoneNum.length != 10 || phoneNum.to_i < 200000000)
	puts "hmm.. that doesn't look right.  Try again (ex. 5102998598)"
	puts "What is your phone number?"
	phoneNum = gets.chomp

end

# binding.pry

begin
	client = Twilio::REST::Client.new account_sid, auth_token

	message = client.account.messages.create({
	    :from => "#{from}",
	    :to => "+1#{phoneNum}",
	    :body=> "#{text}"
	})
	puts "Message, '#{message.body}', sent to #{phoneNum}"
rescue Twilio::REST::RequestError => e
	puts e.message
end
