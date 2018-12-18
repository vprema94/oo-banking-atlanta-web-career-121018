require 'pry'
class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  @@senders = []
  @@receivers = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @status == "complete"
      "Transaction complete."
    elsif @sender.valid? && @sender.balance > @amount
      @receiver.deposit(@amount)
      @sender.deposit(@amount * -1)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.deposit(@amount * -1)
      @sender.deposit(@amount)
      @status = "reversed"
    end
  end

end
