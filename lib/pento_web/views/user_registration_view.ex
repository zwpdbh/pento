defmodule PentoWeb.UserRegistrationView do
  use PentoWeb, :view
  def username_input(form, field, _opts \\ []) do
    # form.input :username, opts
    form.input field
  end
end
