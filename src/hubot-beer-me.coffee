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

BREWERYDB_API_URL="http://api.brewerydb.com/v2/search"

module.exports = (robot) ->
  robot.respond /beer me (.*)/i, (msg) ->
    unless process.env.BREWERYDB_KEY?
      msg.send "Brewery DB API key not set (BREWERDB_KEY)!"
      return
    
    msg.http(BREWERYDB_API_URL)
      .query
        type: "search"
        key: process.env.BREWERYDB_API_KEY
        q: msg.match[1].replace(" ", "+")
      .get() (err, res, body) ->
          data = JSON.parse(body)['data']
          if data
            beer = data[0]
          else
            msg.send "No beer found"
            return
            
          response = beer['name']
          if beer['breweries']?
            response += " (#{beer['breweries'][0]['name']})"
          if beer['style']?
            response += "\n#{beer['style']['name']}"
          if beer['abv']?
            response += "\nABV: #{beer['abv']}%"
          if beer['description']?
            response += "\nDescription: #{beer['description']}"
          msg.send response