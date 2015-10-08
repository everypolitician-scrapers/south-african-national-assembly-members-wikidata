#!/bin/env ruby
# encoding: utf-8

require 'scraperwiki'
require 'wikidata/fetcher'
require 'nokogiri'
require 'open-uri'
require 'pry'

def noko_for(url)
  Nokogiri::HTML(open(url).read) 
end

def wikinames(url)
  noko = noko_for(url)
  binding.pry
  noko.xpath('//table[@class="navbox"]//table//tr[td]/td[1]//a[not(@class="new")]/@title').map(&:text)
end

names = wikinames('https://en.wikipedia.org/wiki/Template:Current_MPs_of_South_Africa')
abort "No names" if names.count.zero?

WikiData.ids_from_pages('en', names).each_with_index do |p, i|
  data = WikiData::Fetcher.new(id: p.last).data rescue nil
  unless data
    warn "No data for #{p}"
    next
  end
  ScraperWiki.save_sqlite([:id], data)
end
