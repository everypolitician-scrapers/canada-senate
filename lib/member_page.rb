# frozen_string_literal: true

require 'scraped'

class MemberPage < Scraped::HTML
  decorator Scraped::Response::Decorator::CleanUrls

  field :id do
    url.split('/').last
  end

  field :name do
    noko.css('h1.biography_card_name').text.sub(/^Senator/, '').tidy
  end

  field :area do
    card_text('biography_card_details_province')
  end

  field :party do
    card_text('biography_card_details_affiliation')
  end

  field :tel do
    card_text('biography_card_details_telephone')
  end

  field :fax do
    card_text('biography_card_details_fax')
  end

  field :email do
    card_node('biography_card_details_email').css('a[href*=mailto]').text
  end

  field :twitter do
    social_network('twitter')
  end

  field :facebook do
    social_network('facebook')
  end

  field :instagram do
    social_network('instagram')
  end

  field :website do
    card_node('biography_card_details_website').css('a/@href').text
  end

  field :image do
    noko.css('img.biography_image/@src').text
  end

  private

  def card_text(css_class)
    card_node(css_class).xpath('./text()').text.tidy
  end

  def card_node(css_class)
    noko.xpath('//li[@class="%s"]' % css_class)
  end

  def social_network(url_part)
    card_node('biography_card_details_social').css('a[href*=%s]/@href' % url_part).text
  end
end
