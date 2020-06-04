defmodule SurfMail.Sender do
  require Logger
  alias SurfMail.{Email, Mailer}

  @doc """
  creates a new welcome email and sends it to the specified destination
  """
  @spec send_welcome_email(String.t()) :: term()
  def send_welcome_email(dest) do
    Email.welcome_email(dest)
    |> Mailer.deliver_now(response: true)
    |> check_successful_send()
  end

  #########################################################################

  # check_successful_send returns :ok if there is a successful status code
  defp check_successful_send({_, %{status_code: status}}) when status in 200..299, do: :ok

  # if there is not a successful status code, print the error to stderr, return :error
  defp check_successful_send(_error) do
    :error
  end
end
