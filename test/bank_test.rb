require 'minitest'
require 'bank'

class BankTest < Minitest::Test
  def test_a_bank_can_be_created
    chase = Bank.new("JP Morgan Chase")

    assert chase.instance_of?(Bank)
  end

  def test_bank_creation_response
    chase = Bank.new("JP Morgan Chase")

    expected = "JP Morgan Chase has been created."

    assert_equal expected, chase.response
  end

  def test_a_person_can_open_an_account_with_the_bank
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)

    expected = "An account has been opened for Minerva with JP Morgan Chase."

    assert_equal expected, chase.open_account(person1)
  end

  def test_a_person_cant_make_a_deposit_before_opening_account
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)

    expected = "Open an account first bro!"

    assert_equal expected, chase.deposit(person1, 750)
  end

  def test_a_person_cant_make_a_deposit_before_opening_account
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)

    expected = "750 galleons have been deposited into Minerva's JP Morgan Chase account. Balance: 750 Cash: 250"

    assert_equal expected, chase.deposit(person1, 750)
  end

  def test_a_person_cant_deposit_more_than_their_cash_level
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)

    expected = "Minerva does not have enough cash to perform this deposit."

    assert_equal expected, chase.deposit(person1, 5000)
  end

  def test_for_balance
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)

    assert_equal 750, person1.bank_accounts[chase.name]
  end

  def test_a_withdrawl_can_be_made
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)

    expected = "Minerva has withdrawn 250 galleons. Balance: 500"

    assert_equal expected, chase.withdrawal(person1, 250)


  end

  def test_an_account_can_be_withdrawn_more_than_once
    chase = Bank.new("JP Morgan Chase")
    person1 = Person.new("Minerva", 1000)
    chase.open_account(person1)
    chase.deposit(person1, 750)
    chase.withdrawal(person1, 100)
    expected = "Minerva has withdrawn 250 galleons. Balance: 400"


    assert_equal expected, chase.withdrawal(person1, 250)
  end

  def test_a_transfer_can_be_made
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    chase.open_account(person1)
    wells_fargo.open_account(person1)
    chase.deposit(person1, 1000)

    expected = "Minerva has transferred 250 galleons from JP Morgan Chase to Wells Fargo."

    assert_equal expected, chase.transfer(person1, wells_fargo, 250)
  end

  def test_cant_transfer_money_to_a_bank_that_they_dont_have_an_account_with
    person1 = Person.new("Minerva", 1000)
    chase = Bank.new("JP Morgan Chase")
    wells_fargo = Bank.new("Wells Fargo")
    chase.open_account(person1)
    chase.deposit(person1, 1000)
    expected = "You don't have an account with Wells Fargo bank."

    assert_equal expected, chase.transfer(person1, wells_fargo, 200)
  end

  def test_total_cash_in_bank
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Steve", 1000)
    chase = Bank.new("JP Morgan Chase")
    chase.open_account(person1)
    chase.open_account(person2)
    chase.deposit(person1, 750)
    chase.deposit(person2, 900)
    assert_equal 1650, chase.total_cash

  end

end
