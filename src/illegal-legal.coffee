# Description
#   Punch in a word or phase and this brain will tell you whether or not it's legal or illegal.
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   robksawyer[@<org>]

rapgen = require("rapgenius-js");


searchSong = (content) ->
  rapgen.searchSong content, "rap", (err, songs) ->
    if err
      msg.send "This may or may not be legal."
    else
      msg.send "This is most definitely illegal."

module.exports = (robot) ->
  robot.respond /hello/, (msg) ->
    msg.reply "Hi! Don't believe anything that I say. None of this can be used against you in a court of law."

  robot.hear /is it i{0,1}l+egal to (.*$)|is (.*) i{0,1}l+egal/i, (msg) ->
    msg.send msg.match[1]
    msg.send searchSong(msg.match[1])
