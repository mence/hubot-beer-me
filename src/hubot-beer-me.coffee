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
      msg.send "Brewery DB API key not set (BREWERYDB_KEY)!"
      return
    
    query = { q: msg.match[1].replace(" ", "+"), key: process.env.BREWERYDB_API_KEY, format: "json" }
    
    msg.http(BREWERYDB_API_URL).query(query).get() (err, res, body) ->
      data = JSON.parse(body)
            
      response = data
      msg.send response