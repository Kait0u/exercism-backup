defmodule RPG.CharacterSheet do
  @msg_welcome "Welcome! Let's fill out your character sheet together."
  @msg_name_question "What is your character's name?\n"
  @msg_class_question "What is your character's class?\n"
  @msg_level_question "What is your character's level?\n"

  def welcome() do
    IO.puts(@msg_welcome)
    :ok
  end

  def ask_name() do
    IO.gets(@msg_name_question) |> String.trim()
  end

  def ask_class() do
    IO.gets(@msg_class_question) |> String.trim()
  end

  def ask_level() do
    IO.gets(@msg_level_question)
    |> String.trim()
    |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()

    character = %{
      class: class,
      level: level,
      name: name
    }

    IO.inspect(character, label: "Your character")
  end
end
