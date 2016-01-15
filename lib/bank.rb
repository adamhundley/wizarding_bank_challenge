
class Bank
attr_reader :response, :name, :accounts

  def initialize(name)
    @name = name
    @response = "#{name} has been created."
    @accounts = []
  end

  def open_account(person)
    accounts << person
    person.bank_accounts[self.name] = 0
    "An account has been opened for #{person.name} with #{self.name}."
  end

  def deposit(person, deposit)
    if accounts.include?(person)
      if deposit > person.cash
        "#{person.name} does not have enough cash to perform this deposit."
      else
        person.bank_accounts[self.name] += deposit
        # require "pry"; binding.pry
        "#{deposit} galleons have been deposited into #{person.name}'s #{self.name} account. Balance: #{person.bank_accounts[self.name]} Cash: #{person.cash - deposit}"
      end
    else
      "Open an account first bro!"
    end
  end

  def withdrawal(person, amount)
    if amount > person.bank_accounts[self.name]
      "Insufficient balance"
    else
      person.bank_accounts[self.name] -= amount
      "#{person.name} has withdrawn #{amount} galleons. Balance: #{person.bank_accounts[self.name]}"
    end
  end

  def transfer(person, bank, amount)
    if amount > person.bank_accounts[self.name]
      "Insufficient funds."
    else
      if bank.accounts.include?(person)
        person.bank_accounts[self.name] -= amount
        person.bank_accounts[bank.name] += amount
        "#{person.name} has transferred #{amount} galleons from #{self.name} to #{bank.name}."
      else
        "You don't have an account with #{bank.name} bank."
      end
    end
  end

  def total_cash
    accounts.reduce(0) do |sum, person|
      sum += person.bank_accounts[self.name]
    end
  end
end
