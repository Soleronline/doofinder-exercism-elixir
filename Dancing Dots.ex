defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  # Please implement the module
  @callback init(opts :: keyword) :: {:ok, opts :: keyword } | {:error, error :: any}
  @callback handle_frame(dot :: DancingDots.Dot.t(), frame_number :: pos_integer, opts :: keyword) :: DancingDots.Dot.t()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  # Please implement the module
  use DancingDots.Animation

  def handle_frame(dot, opacity, _) do
    if rem(opacity, 4) == 0 do
      %{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  # Please implement the module
  use DancingDots.Animation

  def init(opts) do
    velocity = List.keyfind(opts, :velocity, 0) && opts[:velocity]
    if is_nil(velocity) or !is_number(velocity) do
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    else
      {:ok, opts}
    end
  end

  def handle_frame(dot, frame_number, opts) do
    %{dot | radius: dot.radius + (frame_number - 1) * opts[:velocity]}
  end
end
