_ = require('lodash')
request = require('request')
cheerio = require('cheerio')
names = []

printNames = (comms) ->
  console.log comms

@retrieve_standing_committee_names = (callback) =>
  request 'http://www.oksenate.gov/committees/standingcommittees.htm', (error, response, html) ->
    if !error and response.statusCode == 200
      $ = cheerio.load(html)
      $('a[href^="standing/committee_assignments.pdf"]').remove()
      selections = $('a')
      names.push selection.children[0].data.replace(/[^a-zA-Z ]/g, "").replace(/ +(?= )/g,'') for selection in selections
      callback names

@retrieve_standing_committee_names(printNames)
