defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email

  alias Inmana.Supply

  def create(to_email, supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com",
      subject: "Supplies that are about to expire",
      html_body: email_text(to_email, supplies)
    )
  end

  defp email_text(to_email, supplies) do
    initial_text =
      "<h1> Hello #{to_email} </h1>" <> "<h4>Supplies that are about to expire: </h4>"

    Enum.reduce(supplies, initial_text, fn supply, text -> text <> supply_string(supply) end)
  end

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }) do
    "<p>Description: #{description}, Expiration Date: #{expiration_date}, Responsible:
      #{responsible} </p>"
  end
end
