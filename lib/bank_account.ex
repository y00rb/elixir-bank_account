defmodule BankAccount do
  @moduledoc """
  Documentation for BankAccount.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BankAccount.hello
      :world

  """
  def hello do
    :world
  end

  def start do
    play(0)
  end

  def play(amount) do
    receive do
      {:check_balance, from}-> check_balance(from, amount)
      {:deposit, value, from}-> amount=deposit_balance(amount, value)
      {:withdraw, value, from}-> amount=withdraw_balance(amount, value)
    end
    play(amount)
  end
  
  def deposit_balance(amount, value) do
    amount+value
  end
  
  def withdraw_balance(amount, value) do
    amount-value
  end

  def check_balance(pid, amount) do
    send pid, {:balance, amount}
  end
end
