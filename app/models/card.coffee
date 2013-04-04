###
  You'll probably want to define some kind of Card model.

  If you need to define a collection of cards as well, you could also put that in 
  this file if you want to.
###
class window.Card extends Backbone.Model
  defaults:
    rank: 0
    suit: ""

class window.CardCollection extends Backbone.Collection
  model: Card
  initialize: ->
    @createDeck()
    @shuffleDeck()

  createDeck: ->
    console.log "Creating deck"
    deck = _.range 0,52
    pos = 0
    rank = 0
    suit = ""
    while pos < deck.length
      if 0 <= pos and pos <= 12
          rank = pos+2
          suit = "Hearts"
      else if 13 <=pos and pos <= 25
        rank = pos-11
        suit = "Clubs"
      else if 26 <= pos and pos <= 38
        rank = pos-24
        suit = "Diamonds"
      else if 39 <=pos 
        rank = pos-37
        suit = "Spades"
      rank = @setRank(rank)
      @add(rank: rank, suit: suit)
      pos++

  setRank: (current_rank) ->
    if current_rank > 10
      current_rank = 10
    return current_rank

  shuffleDeck: ->
    @.reset @shuffle()

# @cards = []
# for thisSuit in [heart, clubs, diamons, spades]
#   for thisRank in [1...13]
#     @cards.push(new Card({suit: thisSuit, rank: thisRank}))