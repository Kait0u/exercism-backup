defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @base_message "stack underflow occurred"

    defexception message: @base_message

    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

          _ ->
            %StackUnderflowError{message: "#{@base_message}, context: #{value}"}
      end
    end
  end

  def divide(stack) when length(stack) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0 | _]), do: raise DivisionByZeroError
  def divide([divisor | [dividend | []]]), do: dividend / divisor
end
