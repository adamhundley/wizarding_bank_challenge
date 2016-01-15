require 'minitest'
require 'person'
class PersonTest < Minitest::Test

  def test_person_can_be_created
    person1 = Person.new("Minerva", 1000)

    assert person1.instance_of?(Person)
  end

  def test_the_response_when_a_person_is_created
    person1 = Person.new("Minerva", 1000)

    expected = "Minerva has been created with 1000 galleons in cash"
    assert_equal expected, person1.response
  end


end
