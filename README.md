# star-wars-quotes
A very simple gem wrapping up the process of selecting a random star wars quote.


Additional support for selecting a specific character quote or faceted quote is also included.
Initial facets are used to find a quote to show as part of a test related system's output w.r.t. build_passed and build_failed scenarios.
In essence this allows some whimsy to be added to the test report as a way to motivate the developer to fix the issue.


But...these can be replaced with whatever you want.


## Copyright notes
All quotes from the films are owned by their respective rights holders.
The use of these quotes in this gem falls under a "fair use" since they are now part of the fabric of pop culture.


## Installation
```
gem install star_wars_quotes
```
or add to your Gemfile
```
gem 'star_wars_quotes'
```

## Usage examples
```
# create an instance with the star wars quotes
swq = StarWarsQuotes::Api.new

# get random quote
quote = swq.random

# get random quote for passing build
passing_quote = swq.random_by_facet( :build_passed )

# get random quote for failing build
failing_quote = swq.random_by_facet( :build_failed )

# get list of characters
list_of_characters = swq.characters

# get random quote for specific character
character_quote = swq.random_by_character( :'Darth Vader' )

# get list of facets (currently :build_passed + :build_failed )
list_of_facets = swq.facets

# get random quote for specific character and specific facet
character_and_facet_quote = swq.random_by_character_and_facet( :'Darth Vader', :build_passed )

# add a new quote
swq.add_quote( StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] ) )

# create an instance with no star wars quotes
swq = StarWarsQuotes::Api.new( false )
```

## You can add/remove facets to existing quotes since the quotes facets is an array
```
#find the quote you want to edit
q.facets.delete(:build_failure)
q.facets.delete(:build_success)
(or q.facets.clear)
q.facets << :something_else
q.facets << :something_other
```

## Non star wars usage examples (for example Batman)
```
swq = StarWarsQuotes::Api.new( false )
swq.add_quote( StarWarsQuotes::Quote.new( :'Batman', "I'm Batman", [:catchprase, :goodie] ) )
swq.add_quote( StarWarsQuotes::Quote.new( :'Riddler', 'Riddle me this', [:catchprase, :baddie] ) )
...
quote = swq.random
character_quote = swq.random_by_character( :'Batman' )
facet_quote = swq.random_by_facet( :catchprase )
etc...
```

## Building / testing / installing this gem from source
```
rake  (runs tests)
rdoc  (builds docs)
gem build star_wars_quotes.gemspec          (update version before build)
gem install ./star_wars_quotes-1.0.1.gem    (update version)
irb
> require "star_wars_quotes"
> swq = StarWarsQuotes::Api.new( true )
> puts swq.random
gem uninstall star_wars_quotes
```

## Pushing gem
```
gem signin
gem push star_wars_quotes-1.0.1.gem         (update version)
gem list -r star_wars_quotes
```
