#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

sparq = 'SELECT ?item WHERE { ?item p:P39/pq:P2937 wd:Q18109299 }'
wikidata = EveryPolitician::Wikidata.sparql(sparq)

enwiki = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://en.wikipedia.org/wiki/Template:Current_MPs_of_South_Africa',
  xpath: '//div[@role="navigation"]//table//tr[td]/td[1]//a[not(@class="new")]/@title',
  as_ids: true,
)

afwiki = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://af.wikipedia.org/wiki/Sjabloon:Huidige_LP%27s_van_Suid-Afrika',
  xpath: '//div[@role="navigation"]//table//tr[td]/td[1]//a[not(@class="new")]/@title',
  as_ids: true,
)

EveryPolitician::Wikidata.scrape_wikidata(ids: wikidata | enwiki | afwiki)
