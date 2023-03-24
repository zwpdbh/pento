defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  # 1) route call this function to inital state
  def mount(_params, session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       message: "Make a guess:",
       time: time(),
       session_id: session["live_socket_id"]
     )}
  end

  # 2) inital state is then looking for render
  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>

    <h2>
      <%= @message %> It's <%= @time %>
    </h2>

    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
       <pre>
          <%= @current_user.email %>
          <%= @session_id %>
        </pre>
    </h2>
    """
  end

  # If we want our socket state to track other things, we need to modify
  # 1) Mount to make sure it is included in initial state
  # 2) Update it in the handle_event
  # Otherwise it will not be updated.
  defp time() do
    DateTime.utc_now() |> to_string()
  end

  defp target() do
    :rand.uniform(10)
  end

  # 3) User's event will be handled by custom defined handle_event function
  def handle_event("guess", %{"number" => guess} = _data, socket) do
    # message =
    #   case guess = Map.get(socket, :target) do
    #     true -> "Your are correct: #{guess}. Good Work "
    #     false -> "Your guess: #{guess}. Wrong. Guess again. "
    #   end
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1

    {:noreply,
     assign(
       socket,
       time: time(),
       message: message,
       score: score
     )}
  end
end
