# Description
#   Finds some sweet beers!
#
# Configuration:
#   BREWERYDB_KEY
#
# Commands:
#   beer me <beer name> - Finds information about beers
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Dave[@<org>]

module.exports = (robot) ->

  url="http://api.brewerydb.com/v2/search"
  key = process.env.BREWERYDB_KEY

  robot.respond /beer me (.*)/i, (msg) ->
    beer_me msg, key, url
  
  robot.respond /brewery me (.*)/i, (msg) ->
    brewery_me msg, key, url

beer_me = (msg, key, url) ->    
  unless key?
    msg.send "Brewery DB API key not set (BREWERYDB_KEY)!"
    return

  query = { q: msg.match[1].replace(" ", "+"), key: key, format: "json", type: "beer" }
    
  msg.http(url).query(query).get() (err, res, body) ->
    data = JSON.parse(body)['data']
      
    if data
      beer = data[0]
    else
      msg.send "Nothing found"
      return
      
    response = "#{beer['name']}\n"
    if beer['abv']?
      response += "ABV: #{beer['abv']}%\n"
    if beer['description']?
      response += "Description: #{beer['description']}\n"
    if beer['style']?
      response += "Style: #{beer['style']['name']}\n"
    if beer['glass']?
      response += "Glass Style: #{beer['glass']['name']}\n"
      
    msg.send(response)

brewery_me = (msg, key, url) ->
  unless key?
    msg.send "Brewery DB API key not set (BREWERYDB_KEY)!"
    return

  query = { q: msg.match[1].replace(" ", "+"), key: key, format: "json", type: "brewery" }
  msg.http(url).query(query).get() (err, res, body) ->
    data = JSON.parse(body)['data']

    if data
      brewery = data[0]
    else
      msg.send "Nothing found"
      return

    response = "#{brewery['name']}\n"
    if brewery['description']?
      response += "Description: #{brewery['description']}\n"
    if brewery['website']?
      response += "Website: #{brewery['website']}\n"
    if brewery['established']?
      response += "Established: #{brewery['established']}\n"

    msg.send(response)
