require 'test_helper'

class QuoteTest < Minitest::Test

  def test_quote
    quote = StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] )
    assert_equal 'No Disintegrations', quote.statement
    assert_equal :"Darth Vader", quote.character
    assert_equal [:build_failure], quote.facets
    assert_equal "\"No Disintegrations\" - Darth Vader", quote.to_s

    quote = StarWarsQuotes::Quote.new( :"Yoda", 'Do or do not, there is no try', [:build_passed] )
    assert_equal 'Do or do not, there is no try', quote.statement
    assert_equal :"Yoda", quote.character
    assert_equal [:build_passed], quote.facets
    assert_equal "\"Do or do not, there is no try\" - Yoda", quote.to_s
  end

end
