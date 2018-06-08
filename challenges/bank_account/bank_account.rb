class BankAccount

 attr_reader :balance

 def initialize(starting_balance=0)
   @balance = starting_balance
 end

 def check_balance
   "Your balance is $#{@balance}"
 end

 def deposit(amount)
   @balance += amount
 end

 def withdraw(amount)
   if (@balance - amount) >= 0
     @balance -= amount
   end
 end

 def transfer_to(other_account, amount)
   if (@balance - amount) > 0
     withdraw(amount)
     other_account.deposit(amount)
   end
 end

end