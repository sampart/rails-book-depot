module ApplicationHelper

  DOLLAR_TO_EUR = 1.21

  def render_if(condition, record)
    if condition
      render record
    end
  end

  def localise_usd_number_and_format_as_currency(usd)
    case I18n.locale
    when :es
      unit = "€"
      price = usd * DOLLAR_TO_EUR
    else
      unit = "$"
      price = usd
    end
    number_to_currency(price, unit: unit)
  end
end
