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

searchSong = (msg, content) ->
  msg.send content
  rapgen.searchSong content, "rap", (err, songs) ->
    if err
      msg.send "This may or may not be legal."
    else
      msg.send "This is most definitely illegal."

module.exports = (robot) ->
  robot.respond /hello/, (msg) ->
    msg.reply "Hi! Don't believe anything that I say. None of this can be used against you in a court of law."

  robot.hear /is (weed|marajuana) legal/im, (msg) ->
    msg.send "Yep, sure is. But don't get high on your own supply."
    return

  robot.hear /is (weed|marajuana) illegal/im, (msg) ->
    msg.send "Nope, smoke up."
    return

  robot.hear /is it i{0,1}l+egal to (.*$)|is (.*) i{0,1}l+egal/im, (msg) ->
    msg.send msg.match[1]
    searchSong(msg, msg.match[1].toString)
    return