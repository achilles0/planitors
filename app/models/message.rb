class Message < ApplicationRecord

  def get_messages_for_current_user()
    msgs = Message.where("to_user_id = #{current_user.id}")
    if not msgs then
      Message.deliver_welcome_message current_user.id
      msgs = Message.where("to_user_id = #{current_user.id}")
    end
    msgs
  end

  def self.deliver_welcome_message(to_user_id)
    msg = Message.new
    msg.to_user_id = to_user_id
    msg.from_user_id = 1 ## FIXME: Happy
    msg.subject = "Congratulations, new level! Welcome to level 1"
    # FIXME: where should this be stored, really?
    msg.text = <<END
    Welcome to level 1 of Hash1Planet, #1planet!

END
    #This is a kind of game and meeting place for all who care about out the single planet all of us have to share. 
    #The game is divided into levels, where each new level unlocks some new features of the platform. You level up
    #by accepting and completing missions. Hash1planet is also the place to look for news, tips and advice related
    #to saving the climate, bio diversity (that there are many kinds of animals and life forms on the planet), the
    #purity of our skies and waters, and actually all the 17 developemnt goals that United Nations have agreed on.

    #Hash1planet is still in its infancy, as you will surely realize soon. We're very happy you want to take part
    #in this journey with us, and develop a platform for a thriving community to enjoy. Hash1planet is developed by
    #a not-for profit organizaton by the same name.

    #Enjoy, and do let us know what you think!
    #  /Jan Lindblad
#END
    msg.sent_at = Time.now
    msg.save!
    puts "In deliver_welcome_message: #{msg}"
  end  
end
