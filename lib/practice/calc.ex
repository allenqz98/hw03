defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> parse_toks
    |> handle_mul_div
    |> handle_add_sub
    |> hd
    |> return_num

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def parse_toks(list) do
    Enum.map(list, fn(x) -> apply_type(x) end)
  end

  def apply_type(x) do
    if Enum.member?(["+","-","*","/"], x) do
      {:op, x}

    else
      {:num, parse_float(x)}
    end

  end

  def handle_mul_div([{:num, num1} , {:op, "*"} , {:num, num2} | rest]) do
    handle_mul_div([{:num, num1 * num2} | rest])
  end

  def handle_mul_div([{:num, num1} , {:op, "/"} , {:num, num2} | rest]) do
    handle_mul_div([{:num, num1 / num2} | rest])
  end

  def handle_mul_div([first | rest]) do
    [first] ++ handle_mul_div(rest)
  end

  def handle_mul_div([]) do
    []
  end

  def handle_add_sub([{:num, num1} , {:op, "+"} , {:num, num2} | rest]) do
    handle_add_sub([{:num, num1 + num2} | rest])
  end

  def handle_add_sub([{:num, num1} , {:op, "-"} , {:num, num2} | rest]) do
    handle_add_sub([{:num, num1 - num2} | rest])
  end

  def handle_add_sub([first | rest]) do
    [first] ++ handle_add_sub(rest)
  end

  def handle_add_sub([]) do
    []
  end

  def return_num(tuple) do
    elem(tuple,1)
  end


end
