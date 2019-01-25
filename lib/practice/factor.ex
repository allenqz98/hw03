defmodule Practice.Factor do
  def factor(x) do
    factor_help(x, 2, [])
  end

  def factor_help(num, div, list) do
    cond do
      num < div ->
        list
      num == div ->
        list ++ [div]
      rem(num, div) == 0 ->
        factor_help(div(num,div), div, list ++ [div])
      rem(num, div) != 0 ->
        factor_help(num, div + 1, list)
    end
  end

end
