defmodule GuessingGame do
  @correct_message "Correct"
  @close_message "So close"
  @higher_message "Too high"
  @lower_message "Too low"
  @waiting_message "Make a guess"

  def compare(_secret_number), do: @waiting_message
  def compare(_secret_number, guess) when guess == :no_guess, do: @waiting_message
  def compare(secret_number, guess) when guess == secret_number, do: @correct_message
  def compare(secret_number, guess) when abs(secret_number - guess) == 1, do: @close_message
  def compare(secret_number, guess) when guess > secret_number, do: @higher_message
  def compare(secret_number, guess) when guess < secret_number, do: @lower_message
end
