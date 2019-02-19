defmodule Lala.Event do
  @behaviour Access

  @lala [
    eid: 0,
    name: "",
    count: 0,
    max_consume: 0,
    min_consume: 0,
    avg_consume: 0,
    fifty: 0,
    seventy_five: 0,
    ninty: 0,
    ninty_five: 0
  ]

  defstruct @lala

  def fetch(struc, key) do
    {:ok, Map.get(struc, key)}
  end

  def pop(struc, key) do
    {Map.get(struc, key), Map.put(struc, key, Keyword.get(@lala, key))}
  end

end

defmodule Lala do
  use BaseHtml, [html: :lala]
  alias Lala.Event

  def args() do
    [
      onlines: get_onlines(),
      total_num: get_total_num(),
      events: get_infos()
    ]
  end

  def get_onlines() do
    0
  end

  def get_total_num() do
    0
  end

  def get_infos() do
    []
    |> Enum.map(fn {e1, e2, e3, e4, e5, e6, e7, e8, e9, e10} ->
      %Event{
        eid: e1,
        name: e2,
        count: e3,
        max_consume: e4,
        min_consume: e5,
        avg_consume: e6,
        fifty: e7,
        seventy_five: e8,
        ninty: e9,
        ninty_five: e10
      }
    end)
    |> Enum.reject(&is_nil/1)
  end
  
end