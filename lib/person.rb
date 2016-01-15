class Person
attr_reader :name, :cash, :response
attr_accessor :bank_accounts

  def initialize(name, cash)
    @name = name
    @cash = cash
    @response = "#{name} has been created with #{cash} galleons in cash"
    @bank_accounts = {}
  end
end
