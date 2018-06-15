require 'minitest/autorun'
require_relative 'bank_account'

class PhraseTest < MiniTest::Unit::TestCase

 def test_starting_balance_no_arguments
   bankAccount = BankAccount.new 
   starting_balance = 0
   assert_equal starting_balance, bankAccount.balance
 end

 def test_starting_balance_string_argument
   bankAccount = BankAccount.new()
   starting_balance = 0
   assert_equal starting_balance, bankAccount.balance
 end

 def test_starting_balance
   bankAccount = BankAccount.new(300)
   starting_balance = 300
   assert_equal starting_balance, bankAccount.balance
 end 

 def test_deposit
   starting_balance = 300
   bankAccount = BankAccount.new(starting_balance)
   amount = 300

   balance = 600
   bankAccount.deposit(amount)

   assert_equal balance, bankAccount.balance
 end

 def test_withdraw
   starting_balance = 300
   bankAccount = BankAccount.new(starting_balance)
   amount = 300
   
   balance = 0
   bankAccount.withdraw(amount)

   assert_equal balance, bankAccount.balance
 end

def transfer_to
   
   bank_account_a = BankAccount.new(1000)
   bank_account_b = BankAccount.new(500)
   bank_account_a.transfer_to(bank_account_b,250)
   

   assert_equal bank_account_a.balance, bank_account_b.balance
 end

end