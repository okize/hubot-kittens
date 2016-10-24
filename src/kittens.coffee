# Description:
#   Kittens!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot kitten me - A randomly selected kitten
#   hubot kitten me <w>x<h> - A kitten of the given size
#   hubot kitten bomb me <number> - Many many kittens!
#
# Author:
#   dstrelau, rjanardhana

module.exports = (robot) ->
  MIN_KITTENS = 1
  MAX_KITTENS = 10

  robot.respond /kittens?(?: me)?$/i, (msg) ->
    msg.send kittenMe()

  robot.respond /kittens?(?: me)? (\d+)(?:[x ](\d+))?$/i, (msg) ->
    msg.send kittenMe msg.match[1], (msg.match[2] || msg.match[1])

  robot.respond /kitten bomb(?: me)?( \d+)?$/i, (msg) ->
    kittens = msg.match[1] || 5
    clampedKittens = clampKittensCount(kittens, MIN_KITTENS, MAX_KITTENS)
    if kittens > MAX_KITTENS
        msg.send "Buzzkill Mode™ has enforced maximum kittens to #{clampedKittens}"
    msg.send(kittenMe()) for i in [1..clampedKittens]

  clampKittensCount = (count, min, max) ->
    return Math.min(Math.max(count, min), max)

  kittenMe = (height, width) ->
    h = height ||  Math.floor(Math.random() * 250) + 250
    w = width  || Math.floor(Math.random() * 250) + 250
    root = "http://placekitten.com"
    root += "/g" if Math.random() > 0.5 # greyscale kittens!
    return "#{root}/#{h}/#{w}#.png"
