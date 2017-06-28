#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'
require 'pry'

sparq = <<EOQ
  SELECT ?item
  WHERE {
    ?item p:P39 ?position_statement .
    ?position_statement ps:P39 wd:Q16744266 ;
                        pq:P2937 wd:Q18109299 .
  }
EOQ

ids = EveryPolitician::Wikidata.sparql(sparq)

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/Template:Current_MPs_of_South_Africa',
  xpath: '//div[@role="navigation"]//table//tr[td]/td[1]//a[not(@class="new")]/@title',
)
EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: names })
