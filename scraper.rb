#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

sparq = 'SELECT ?item WHERE { ?item p:P39/pq:P2937 wd:Q18109299 }'
ids = EveryPolitician::Wikidata.sparql(sparq)

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/Template:Current_MPs_of_South_Africa',
  xpath: '//div[@role="navigation"]//table//tr[td]/td[1]//a[not(@class="new")]/@title',
)
EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names })
