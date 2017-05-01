defmodule BankAccountTest do
  use ExUnit.Case
  doctest BankAccount

  test "starts off with balance of 0" do
    account = spawn_link(BankAccount, :start, [])
    verify_balance_is 0, account
  end

  test "has balance increment by amount of a deposit" do
    account = spawn_link(BankAccount, :start, [])
    send account, {:deposit, 10, self()}
    verify_balance_is 10, account
  end

  test "has balance decrement by amount of a deposit" do
    account = spawn_link(BankAccount, :start, [])
    send account, {:deposit, 20, self()}
    send account, {:withdraw, 10, self()}
    verify_balance_is 10, account
  end

  def verify_balance_is(amount, account) do
    send account, {:check_balance, self()}
    assert_receive {:balance, ^amount}
  end
end
