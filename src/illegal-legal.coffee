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
  

lyricsSearchCb = (lyricsAndExplanations) ->
    if err
      return "Yeah, that's legal."
    else
      return "That's totally illegal."
      # Printing lyrics with section names
      #lyrics = lyricsAndExplanations.lyrics;
      #explanations = lyricsAndExplanations.explanations;
      #console.log("Found lyrics for song [title=%s, main-artist=%s, featuring-artists=%s, producing-artists=%s]",
      #  lyrics.songTitle, lyrics.mainArtist, lyrics.featuringArtists, lyrics.producingArtists);
      #console.log("**** LYRICS *****\n%s", lyrics.getFullLyrics(true));

      #Now we can embed the explanations within the verses
      #lyrics.addExplanations(explanations);
      #var firstVerses = lyrics.sections[0].verses[0];
      #console.log("\nVerses:\n %s \n\n *** This means ***\n%s", firstVerses.content, firstVerses.explanation);

module.exports = (robot) ->
  robot.respond /hello/, (msg) ->
    msg.reply "Hi! Don't believe anything that I say. None of this can be used against you in a court of law."

  robot.hear /is it i{0,1}l+egal to (.*$)|is (.*) i{0,1}l+egal/igm, ->
  	msg.send msg.match[1]
    msg.send searchSong(msg.match[1])
