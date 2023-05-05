module StarWarsQuotes
# The main Api class containing the bulk of the api
  class Api
    include Enumerable
    #Might consider adding array like actions in the future via
    #extend Forwardable
    #def_delegators :@garage, :size, :length, :[], :empty?, :last, :index

    # characters the list of available characters
    attr_reader :characters
    # facets the list of available facets
    attr_reader :facets

    # Initializes the star wars quotes class and api
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   => instance of the star wars quotes api
    def initialize( populate=true )
      @quotes = []
      if populate
        populate_quotes
      end
      update_characters
      update_facets
    end

    # defines how enumeration works
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> swq.each do {|x| puts "\"#{x.statement}\" - #{x.character}" }
    #    >> swq.each do {|x| puts x.to_s }  (same output as above)
    #   => prints each quote
    #
    # Arguments:
    #   &block: (Block) the block to pass to each element
    def each(&block)
      @quotes.each(&block)
    end

    # adds a quote the list of quotes
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> quote = StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] )
    #   >> swq.add_quote( quote )
    #
    # Arguments:
    #   quote: (Quote) the quote to be added
    def add_quote( quote )
      @quotes << quote
      update_characters
      update_facets
    end

    # retrieves a random quote from the list of quotes
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> quote = swq.random
    #
    # Returns:
    #   (Quote) the randomly selected quote
    def random
      @quotes.sample
    end

    # retrieves a random quote from the list of quotes for a specific character
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> quote = swq.random_by_character( :"Darth Vader" )
    #
    # Returns:
    #   (Quote) the randomly selected quote
    def random_by_character( character_symbol )
      character_as_symbol = character_symbol.to_sym
      @quotes.filter {|x| x.character.eql?( character_as_symbol ) }.sample
    end

    # retrieves a random quote from the list of quotes for a specific facet
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> quote = swq.random_by_facet( :build_failure )
    #
    # Returns:
    #   (Quote) the randomly selected quote
    def random_by_facet( facet_symbol )
      facet_as_symbol = facet_symbol.to_sym
      @quotes.filter {|x| x.facets.include?( facet_as_symbol ) }.sample
    end

    # retrieves a random quote from the list of quotes for a specific character and facet
    #
    # Example:
    #   >> swq = StarWarsQuotes::Api.new
    #   >> quote = swq.random_by_character_and_facet( :"Darth Vader", :build_failure )
    #
    # Returns:
    #   (Quote) the randomly selected quote
    def random_by_character_and_facet( character_symbol, facet_symbol )
      character_as_symbol = character_symbol.to_sym
      facet_as_symbol = facet_symbol.to_sym
      @quotes.filter {|x| x.character.eql?( character_as_symbol ) && x.facets.include?( facet_as_symbol ) }.sample
    end

    private

    def update_characters
      @characters = @quotes.collect {|x| x.character }.uniq!
    end

    def update_facets
      @facets = @quotes.collect {|x| x.facets }.flatten.uniq!
    end

    def populate_quotes
      @quotes << StarWarsQuotes::Quote.new('Admiral Ackbar', "It's a trap!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Ahsoka Tano', "I like firsts. Good or bad, they're always memorable.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Ahsoka Tano', "I've seen what such feelings can do to a fully trained Jedi Knight. To the best of us.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Ahsoka Tano', "You don't have to look tough to be tough.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Anakin Skywalker', "Attachment is forbidden. Possession is forbidden. Compassion, which I would define as unconditional love, is essential to a Jedi's life. So you might say, that we are encouraged to love.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Anakin Skywalker', "Mom, you said that the biggest problem in this universe is nobody helps each other.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Anakin Skywalker', "Someday I will be the most powerful Jedi ever.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Anakin Skywalker', "Sometimes we must let go of our pride and do what is requested of us.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Anakin Skywalker', "You're asking me to be rational. That is something that I know I cannot do. Believe me, I wish I could just wish away my feelings, but I can't.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "Roger Roger", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "Ah, well. It's my programming.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "Ah, well. It's my programming.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "The navicomputer is heading us straight into the moon.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "Look! A little green life form!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "But I just got promoted!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "That was impressive!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Battle Droid', "I'll go give him the good news.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Boba Fett', "He's no good to me dead.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Boba Fett', "I don't want your armor. I want my armor.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Boba Fett', "You can only get so far without a tribe.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "Don't call me a mindless philosopher, you overweight glob of grease.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "He's quite clever, you know...for a human being.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "I suggest a new strategy, Artoo: Let the Wookiee win.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "I'm rather embarrassed, General Solo, but it appears that you are to be the main course at a banquet in my honor.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "Sir, the possibility of successfully navigating an asteroid field is approximately 3,720 to 1", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "We seem to be made to suffer. It's our lot in life.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('C-3PO', "We're doomed.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Captain Rex', "In my book, experience outranks everything.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Cara Dunne', "Dank farrik.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Cassian Andor', "Make ten men feel like a hundred.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Chirrut Îmwe', "I am one with the Force and the Force is with me.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Chirrut Îmwe', "I fear nothing. For all is as the Force wills it.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Cobb Vanth', "I guess every once in a while both suns shine on a womp rat's tail.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Count Dooku', "I sense great fear in you, Skywalker. You have hate. You have anger. But you don't use them.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "Be careful not to choke on your aspirations, director.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "I find your lack of faith disturbing.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "If you only knew the power of the dark side.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "No. I am your father.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "The Force is strong with this one.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "When I left you, I was but the learner. Now I am the master.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "You have controlled your fear. Now, release your anger. Only your hatred can destroy me.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Darth Vader', "You have failed me for the last time.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "I can bring you in warm, or I can bring you in cold.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "I'm a Mandalorian. Weapons are part of my religion.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "I'm not leaving my fate up to chance.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "Loyalty and solidarity are the Way.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "Sorry lady. I don't understand frog.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Din The Mandalorian', "This is the Way.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Director Orson Krennic', "We stand here amidst my achievement. Not yours!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Emperor Palpatine', "Do it.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Emperor Palpatine', "Long have I waited, and now your coming together is your undoing.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Emperor Palpatine', "Stand together, die together. Let your death be the final word in the story of rebellion.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Emperor Palpatine', "You are nothing. A scavenger girl is no match for the power in me. I am all the Sith.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Ezra Bridger', "Stormbloopers. Bucket brain. Buckethead.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Finn', "I'm a big deal in the resistance.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Grand Admiral Thrawn', "To defeat an enemy, you must know them. Not simply their battle tactics, but their history, philosophy, art.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Grand Inquisitor', "There are some things far more frightening than death.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Greef Karga', "Come on, baby! Do the magic hand thing.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Chewie, we're home.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Great, kid, don't get cocky.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Hokey religions and ancient weapons are no match for a good blaster at your side, kid.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "I thought they smelled bad on the outside!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "It's mutual, trust me. She belongs with me.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "It's the ship that made the Kessel Run in less than 12 parsecs.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Laugh it up, fuzzball!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Let's keep a little optimism here.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Never tell me the odds!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Punch it!", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Some moof milker put a compressor on the ignition line.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Traveling through hyperspace ain't like dusting crops, farm boy.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "Women always figure out the truth. Always.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Han Solo', "You like me because I'm a scoundrel. There aren't enough scoundrels in your life.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Hondo Ohnaka', "As my sweet mother always said, ‘Son, if one hostage is good, two are better. And three, well, that's good business.'", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Hondo Ohnaka', "Insolence? We are pirates. We don't even know what that means.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Jango Fett', "I'm just a simple man trying to make my way in the universe.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Jar Jar Binks', "How wude!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Jar Jar Binks', "Meesa sorry!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Jyn Erso', "If we can make it to the ground, we'll take the next chance. And the next. On and on until we win … or the chances are spent.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Jyn Erso', "It's not a problem if you don't look up.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Jyn Erso', "Rebellions are built on hope.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('K-2SO', "Congratulations. You are being rescued.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('K-2SO', "I find that answer vague and unconvincing.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Kanan Jarrus', "Battles leave scars...some you can't see.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Kylo Ren', "Let the past die. Kill it if you have to.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Kylo Ren', "I know what I have to do.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Kylo Ren', "Let the past die. Kill it.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Lando Calrissian', "Here goes nothing.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Lando Calrissian', "I got a bad feeling about this.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Lando Calrissian', "We had each other. That's how we won.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Lando Calrissian', "You really have it bad for the Falcon, don't you?", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Aren't you a little short for a stormtrooper?", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Get your head out of your cockpit.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Help me, Obi-Wan Kenobi. You're my only hope.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "I'd just as soon kiss a Wookiee.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Never underestimate a droid.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "She was more interested in protecting the Light than seeming like a hero.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Some day you're gonna be wrong, I just hope I'm there to see it.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Somebody has to save our skins. Into the garbage chute, flyboy.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Why, you stuck up, half-witted, scruffy-looking…nerf-herder!", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Leia Organa', "Will somebody get this big walking carpet out of my way?", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "Confronting fear is the destiny of a Jedi. Your destiny.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "Get back up. Always get back up.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "I have a very bad feeling about this.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "I won't fail you. I'm not afraid.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "I'll not leave you here. I've got to save you.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "I've seen this raw strength only once before. It didn't scare me enough then. It does now.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "It's not impossible. I used to bullseye womp rats in my T-16 back home; they're not much bigger than two meters.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "Let go of your hate.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "Strike me down in anger and I'll always be with you, just like your father.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "The Force is not a power you have. It's not about lifting rocks. It's the energy between all things, a tension, a balance, that binds the universe together.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "The Force is strong in my family. My father has it. I have it. My sister has it.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "We'll always be with you. No one's ever really gone. A thousand generations live in you now.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "We've passed on all we know. A thousand generations live in you now. But this is your fight.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Luke Skywalker', "You'll find I'm full of surprises.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Maz Kanata', "Dear child, the belonging you seek is not behind you...it is ahead", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Maz Kanata', "The Force, it's calling to you. Just let it in.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Moff Gideon', "A friendly piece of advice; assume that I know everything.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "A great leap forward often requires first taking two steps back.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Be mindful of your thoughts Anakin. They'll betray you.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Don't give in to hate. That leads to the Dark Side.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Dreams pass in time.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Hello there.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "I have a bad feeling about this.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "If you strike me down, I shall become more powerful than you can possibly imagine.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "In my experience, there's no such thing as luck.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "It's over Anakin, I have the high ground.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Many of the truths that we cling to depend on our viewpoint.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Master Yoda says I should be mindful of the future.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Mos Eisley spaceport. You will never find a more wretched hive of scum and villainy.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Only a Sith deals in absolutes.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Remember…the Force will be with you, always.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "That's no moon. It's a space station.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "These aren't the droids you're looking for.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "This is the weapon of a Jedi Knight. Not as clumsy or random as a blaster; an elegant weapon for a more civilized age.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Use the Force, Luke.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Who's the more foolish? The fool or the fool who follows him?", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Why do I get the feeling you're going to be the death of me?", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "You don't need to see his identification.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "You were my brother, Anakin. I loved you.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "You were the chosen one! It was said that you would destroy the Sith, not join them. You were to bring balance to the Force, not leave it in darkness.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Obi-Wan Kenobi', "Your eyes can deceive you, don't trust them.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "All mentors have a way of seeing more of our faults than we would like. It's the only way we grow.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "I was not elected to watch my people suffer and die while you discuss this invasion in a committee.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "I'm not afraid to die. I've been dying a little bit each day since you came back into my life.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "So this is how liberty dies...with thunderous applause.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "To be angry is to be human.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Padme Amidala', "What if the democracy we thought we were serving no longer exists, and the Republic has become the very evil we have been fighting to destroy?", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Poe Dameron', "The First Order wins by making people think they are alone. We're not alone. Good people will fight if we lead them.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Qui-Gon Jinn', "Remember, Your focus determines your reality.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Qui-Gon Jinn', "The ability to speak does not make you intelligent.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Qui-Gon Jinn', "There's always a bigger fish.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "I did want to take your hand, Ben's hand.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "I need someone to show me my place in all of this.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "I think I can handle myself.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "I've seen your daily routine. You are not busy.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "Light. Darkness. A balance.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "People keep telling me they know me. No one does.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Rey', "Something inside me has always been there, but now it's awake.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Rio Durant', "Have you ever tried to disinvite a Wookie to anything? Not a good idea.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Riyo Chuchi', "To die for one's people is a great sacrifice. To live for one's people, an even greater sacrifice. I choose to live for my people.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Rose Tico', "That's how we're gonna win. Not fighting what we hate, saving what we love.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Saw Gerrera', "Save the Rebellion! Save the dream.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Shmi Skywalker', "Now, be brave, and don't look back.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Shmi Skywalker', "You can't stop change any more than you can stop the suns from setting.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Supreme Leader Snoke', "As long as he lives, hope lives.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Supreme Leader Snoke', "There has been an awakening. Have you felt it?", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Supreme Leader Snoke', "You're just a child in a mask.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "A Jedi uses the Force for knowledge and defense, never for attack.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Adventure. Heh! Excitement. Heh! A Jedi craves not these things.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Difficult to see; always in motion is the future.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Do or do not. There is no try.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Fear is the path to the dark side. Fear leads to anger. Anger leads to hate. Hate leads to suffering. I sense much fear in you.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "In a dark place we find ourselves and a little more knowledge lights our way.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Judge me by my size, do you?", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Life creates, makes it grow. Its energy surrounds us and binds us. Luminous beings are we, not this crude matter", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "No longer certain that one ever does win a war, I am.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Once you start down the dark path, forever will it dominate your destiny.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Size matters not.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "The fear of loss is a path to the dark side.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Train yourself to let go of everything you fear to lose.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "Wars not make one great.", [:build_failed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "When 900 years old you reach, look as good you will not.", [:build_passed] )
      @quotes << StarWarsQuotes::Quote.new('Yoda', "You must unlearn what you have learned.", [:build_failed] )
    end

  end

end
