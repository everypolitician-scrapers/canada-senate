# frozen_string_literal: true

require 'scraped'

class MemberRow < Scraped::HTML
  field :sort_name do
    td.first.attr('data-order')
  end

  field :source do
    td.first.css('a/@href').text
  end

  field :phone do
    td[2].text.tidy
  end

  field :fax do
    td[3].text.tidy
  end

  field :email do
    td[4].text.tidy
  end

  private

  def td
    noko.css('td')
  end
end
