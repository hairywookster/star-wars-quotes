require 'test_helper'

class ApiTest < Minitest::Test

  def test_init
    swq = StarWarsQuotes::Api.new
    total = swq.count
    assert total > 100

    swq = StarWarsQuotes::Api.new(false)
    total = swq.count
    assert_equal 0, total
  end

  def test_add_quote
    swq = StarWarsQuotes::Api.new
    total = swq.count
    swq.add_quote( StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] ) )
    swq.add_quote( StarWarsQuotes::Quote.new( :"Yoda", 'Do or do not, there is no try', [:build_passed] ) )
    assert_equal (total+2), swq.count
  end

  def test_add_remove_facet_to_quote
    swq = StarWarsQuotes::Api.new
    q = StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] )
    swq.add_quote( q )
    q.facets.clear
    q.facets << :something_else
    q.facets << :something_other
    assert_equal [:something_else, :something_other], q.facets
  end

  def test_enumeration
    swq = StarWarsQuotes::Api.new
    swq.add_quote( StarWarsQuotes::Quote.new( :"Darth Vader", 'No Disintegrations', [:build_failure] ) )
    swq.add_quote( StarWarsQuotes::Quote.new( :"Yoda", 'Do or do not, there is no try', [:build_passed] ) )
    total = 0
    swq.each {|x| assert_kind_of StarWarsQuotes::Quote, x ; total+=1 }
    assert_equal swq.count, total
  end

  def test_characters
    swq = StarWarsQuotes::Api.new
    assert_includes swq.characters, :"Darth Vader"
    assert_includes swq.characters, :"Yoda"
    assert swq.characters.size > 10
  end

  def test_facets
    swq = StarWarsQuotes::Api.new
    assert_includes swq.facets, :build_passed
    assert_includes swq.facets, :build_failed
    assert swq.facets.size == 2
  end

  def test_random
    swq = StarWarsQuotes::Api.new
    quotes = []
    (1..100).each do |x|
      random_quote = swq.random
      assert_kind_of StarWarsQuotes::Quote, random_quote
      quotes << random_quote
      break if quotes.uniq.size > 1
    end
    assert quotes.uniq.size
  end

  def test_random_by_character
    swq = StarWarsQuotes::Api.new
    random_quote = swq.random_by_character( :"Yoda" )
    assert_kind_of StarWarsQuotes::Quote, random_quote
    assert_equal :"Yoda", random_quote.character
    assert random_quote.statement.size > 0
  end

  def test_random_by_facet
    swq = StarWarsQuotes::Api.new
    random_quote = swq.random_by_facet( :build_passed )
    assert_kind_of StarWarsQuotes::Quote, random_quote
    assert_includes random_quote.facets, :build_passed
  end

  def test_random_by_character_and_facet
    swq = StarWarsQuotes::Api.new
    random_quote = swq.random_by_character_and_facet( :"Darth Vader", :build_passed )
    assert_kind_of StarWarsQuotes::Quote, random_quote
    assert_equal :"Darth Vader", random_quote.character
    assert_includes random_quote.facets, :build_passed

    random_quote = swq.random_by_character_and_facet( :"Darth Vader", :build_failed )
    assert_kind_of StarWarsQuotes::Quote, random_quote
    assert_equal :"Darth Vader", random_quote.character
    assert_includes random_quote.facets, :build_failed
  end

end
