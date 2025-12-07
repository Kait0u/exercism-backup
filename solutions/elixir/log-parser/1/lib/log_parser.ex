defmodule LogParser do
  @line_separator_regex ~r/\<[\~\*\=\-]*\>/
  @artifact_regex ~r/end\-of\-line\d+/i
  @user_regex ~r/User\s+([^\s]+)/u

  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  end

  def split_line(line) do
    String.split(line, @line_separator_regex)
  end

  def remove_artifacts(line) do
    Regex.replace(@artifact_regex, line, "")
  end

  def tag_with_user_name(line) do
    capture_result = Regex.run(@user_regex, line)
    IO.puts(capture_result)
    case capture_result do
      [_ | [name | _]] -> "[USER] #{name} #{line}"
      _ -> line
    end
  end
end
