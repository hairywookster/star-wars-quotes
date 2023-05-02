module StarWarsQuotes
  # The Quote class - a simple wrapper around the quote, the character who said it, and related details tot he type of quote.
  class Quote
    # statement is the thing the character said
    attr_reader :statement
    # character is who said it
    attr_reader :character
    # quote_aspects relate to how the quote is perceived
    attr_reader :facets

    # Initializes a new quote instance
    # Example:
    #   >> StarWarsQuotes::Quote.new( :'Darth Vader', 'some interesting statement', [:build_success] )
    #   => new instance of quote
    #
    # Arguments:
    #   character: (Symbol) the character who is being quoted
    #   statement: (String) the thing being said by the character i.e. the quotation
    #   facets: (Array of Symbols) the facets of this quote (facet being some characteristic)
    def initialize( character, statement, facets )
      @character = character.to_sym
      @statement = statement
      @facets = facets
    end

    # Returns a string that can be used to render the quote.
    # If you need a different format you can build your own using the attribute readers...
    # Example:
    #   >> q = StarWarsQuotes::Quote.new( :'Darth Vader', 'some interesting statement', [:build_success] )
    #   => q._to_s    ("some interesting statement" - Darth Vader)
    #
    # Returns:
    #   (String) the textual version of the quote ready for display
    def to_s
      "\"#{@statement}\" - #{@character}"
    end
  end

end
