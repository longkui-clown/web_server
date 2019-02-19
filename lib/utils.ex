defmodule Utils do
  defmacro to_atom(string) do
    if Mix.env == :dev do
      quote do: String.to_atom(unquote(string))
    else
      quote do: String.to_atom(unquote(string))
    end
  end

  defmacro ensure_module(mod) do
    if Mix.env == :dev do
      quote do: Code.ensure_loaded(unquote(mod))
    end
  end

  def to_tuple(list) when is_list(list) do
    List.to_tuple(list)
  end

  def to_tuple(tuple) when is_tuple(tuple) do
    tuple
  end

  def to_string(atom) when is_atom(atom) do
    Atom.to_string atom
  end

  def to_string(int) when is_integer(int) do
    Integer.to_string int
  end

  ## 当天凌晨的时间戳
  def get_day_0_time() do
    Timex.local |> Timex.beginning_of_day |> Timex.to_unix
  end

  #---------------------------------------------------------------------
  # UTC时间戳(秒)
  # @local_zone Timex.local().time_zone
  def timestamp() do
    System.system_time(:second)
  end

  def timestamp(:ms) do
    System.system_time(:millisecond)
  end

  # 时间转时间戳，格式：{{2013,11,13}, {18,0,0}}
  def timestamp(date_time) do
    Timex.to_unix(Timex.to_datetime(date_time, "Etc/UTC"))
  end

  # 时间戳转时间
  def timestamp_to_datetime(time_stamp) do
    Timex.to_datetime(Timex.from_unix(time_stamp), Timex.local().time_zone)
  end

  #---------------------------------------------------------------------
  # Week day
  @seonds_hour 60 * 60
  @seonds_one_day 24 * @seonds_hour
  def day_of_week() do
    day_of_week(Timex.local)
  end

  def day_of_week(local_time) do
    Timex.weekday(local_time)
  end

  # 从周一0点至今
  def seconds_from_monday(week_day, hours, minutes, seconds \\ 0) do
    (week_day - 1) * @seonds_one_day + hours * @seonds_hour + minutes * 60 + seconds
  end

  def seconds_from_monday() do
    now = Timex.local
    Timex.diff(now, Timex.beginning_of_week(now, :mon), :seconds)
  end

  # 从本日0点至今
  def seconds_from_am0(hours, minutes, seconds \\ 0) do
    hours * @seonds_hour + minutes * 60 + seconds
  end

  def seconds_from_am0() do
    date = Timex.local
    date_am0 = date |> Timex.beginning_of_day
    Timex.diff(date, date_am0, :seconds)
  end

  #---------------------------------------------------------------------
  # 处理C#模式文字格式化, 目前默认按顺序处理参数列表, 参数必须可转换为字符串
  # 若存在乱序填充且需精确匹配, 将使用reduce与slice截取生成子串列表与索引列表

  # 构造格式串子串列表
  def format_make_fmt_list(format_str) when is_binary(format_str) do
    format_str |> String.split(~r"\{[0-9]\}")
  end

  # 使用格式串依次插入参数
  def format_string(format_str, param_list) when is_binary(format_str) do
    format_str |> String.split(~r"\{[0-9]\}") |> format_string(param_list)
  end

  # 使用子串列表依次插入参数
  def format_string(str_list, param_list) when is_list(str_list) do
    {result_list, _} = str_list |> Enum.reduce({[], param_list}, fn str_item, {lst, param_list} ->
      case param_list do
        [param | param_list] ->
            {[str_item | lst] |> (fn lst -> [Kernel.to_string(param) | lst] end).(), param_list}
        _ ->
          {[str_item | lst], param_list}
        end
    end)

    List.to_string(Enum.reverse(result_list))
  end

  def decrement_crontab(expression, seconds) do
    alias Crontab.CronExpression.Parser
    alias Crontab.CronExpression.Composer

    %{hour: [h], minute: [m]} = corn = Parser.parse! expression
    case m do
      [:*] -> expression
      _ ->
        s = h * 3600 + m * 60
        s = s - seconds
        s = if s < 0, do: 24 * 3600 + s, else: s
        h = s / 3600 |> trunc
        m = (s - h * 3600) / 60 |> trunc
        s = s - h * 3600 - m * 60

        Map.merge(corn, %{extended: true, hour: [h], minute: [m], second: [s]})
        |> Composer.compose
    end
  end
end
