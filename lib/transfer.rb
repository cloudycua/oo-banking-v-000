class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid? ? true : false
  end

  def execute_transaction
    if status == "pending" && self.valid?
      sender.balance = sender.balance - amount
      receiver.balance = receiver.balance + amount
      @status = "complete"
    elsif !sender.valid?
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  +   def execute_transaction
  +     if self.both_valid? && self.status != "complete" && @sender.balance > @amount
  +        @sender.balance -= @amount
  +        @receiver.balance += @amount
  +        self.status = "complete"
  +     else
  +       self.reject_transfer
  +     end
  +   end

end
