defmodule SurfMail.Email do
  import Bamboo.Email

  @spec welcome_email(String.t()) :: %Bamboo.Email{}
  def welcome_email(dest) when is_bitstring(dest) do
    new_email(
      to: dest,
      # from: Application.fetch_env!(:mailer, :dev_email),
      from: Application.fetch_env!(:surf_mail, :source_email),
      subject: "Welcome to Surf's Up!",
      html_body:
        "<h1>You'll receive daily notifications about which of your selected spots are performing well. To change or stop notifications, go to your profile.</h1>",
      text_body:
        "You'll receive daily notifications about which of your selected spots are performing well. To change or stop notifications, go to your profile."
    )
  end
end
