# Description
#   Punch in a word or phase and this brain will tell you whether or not it's legal or illegal.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   is it legal to X - Let's you know whether or not something is legal
#   is it illegal to X - Let's you know whether or not something is illegal
#   is X legal - Tells you whether or not something thing is legal
#   is X illegal - Tells you whether or not something thing is illegal
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   robksawyer[@<org>]

rapgen = require("rapgenius-js");

legal_resp = [
  "I'm just going to go ahead and guess that this is probably legal."
  "Yeah, probably legal."
  "Um, duh. Yeah it's legal."
  "Yes this is legal."
]

illegal_resp = [
  "No you idiot, it's not legal."
  "Really, you even have to ask?"
  "Nope, totally not legal."
  "No this is not legal."
  "I've determined this illegal"
]

#
# Returns a random integer between min (inclusive) and max (inclusive)
# Using Math.round() will give you a non-uniform distribution!
#
getRandomInt = (min, max) ->
  return Math.floor(Math.random() * (max - min + 1)) + min

getLegalRepsonse = () ->
  return legal_resp[getRandomInt(0,legal_resp.length-1)]

getIllegalRepsonse = () ->
  return illegal_resp[getRandomInt(0,illegal_resp.length-1)]

searchSong = (msg, val) ->
  rapgen.searchSong val, "rap", (err, songs) ->
    if err
      msg.send getLegalRepsonse()
      return
    else
      illegal_resp = getIllegalRepsonse()
      legal_resp = getLegalRepsonse()
      msg.send rapgen.searchLyricsAndExplanations songs[0].link, "rap", (legal_resp, illegal_resp) ->
        if err
          legal_resp
        else 
          illegal_resp
  return



module.exports = (robot) ->

  robot.respond /legal/i, (msg) ->
    msg.send getLegalRepsonse()

  robot.respond /illegal/i, (msg) ->
    msg.send getIllegalRepsonse()

  robot.respond /hello/, (msg) ->
    msg.reply "Hi! Don't believe anything that I say. None of this can be used against you in a court of law."

  robot.hear /is it i{0,1}l+egal to (.*$)|is (.*) i{0,1}l+egal/im, (msg) ->
    searchSong(msg, msg.match[1])
