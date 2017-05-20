# frozen_string_literal: true

require 'scraped'

class MembersPage < Scraped::HTML
  decorator Scraped::Response::Decorator::CleanUrls

  field :members do
    contact_table.xpath('.//tr[td]').map { |tr| fragment tr => MemberRow }
  end

  private

  def contact_table
    noko.css('.senate-contact-table')
  end
end
