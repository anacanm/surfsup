defmodule SurfMail do
  defdelegate send_welcome_email(dest), to: SurfMail.Sender
end
