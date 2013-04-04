###
  This is how you define a class in coffeescript. Internally it does what
  Backbone.View.extend does.

  You need to explicitly define your class as a property of the global window
  object, because coffeescript is always executed in an anonymous function scope 
  instead of the global scope. 
  
  You can still normally access the class as BlackjackView everywhere, though.
###
class window.BlackjackView extends Backbone.View
  el: $ 'body'

  events:
    "click .hit-button": "hit"
    "click .stand-button": "stand"
    "click .reset-button": "reset"

  ###
    In the constructor you'll want to define the variables that contain the
    state of the game. Some examples that could be useful are already in there.

    Remember, in coffeescript you use an  instead of this.
  ###
  initialize: ->
    # this is how you call a member function
    _.bindAll @
    @player = []
    @dealer = []
    @collection = new window.CardCollection
    @reset()
    @render()


  ###
    This function is meant to reset the game state whenever a new round starts.
  
    You'll probably want to set some instance properties, render 
  ###
  reset: ->
    alert "game starting"
    @player = []
    @dealer = []
    @clearBoard()
    @hit()
    @hit()
    @hitDealer()
    @hitDealer()


  render: ->
    @clearBoard()
    @.$('.dealer-cards').html @showCards(@dealer)
    @.$('.player-cards').html @showCards(@player)
    @.$('.dealer-score').append @getScore(@dealer)
    @.$('.player-score').append @getScore(@player)

  clearBoard: ->
    @.$('.dealer-cards').empty()
    @.$('.player-cards').empty()
    @.$('.dealer-score').empty()
    @.$('.player-score').empty()
    @.$('.final-result').empty()

  showCards: (person) ->
    i = 0
    htmlOutput = "<ul>"
    while (i < person.length)
      htmlOutput += "<li> #{person[i].get 'rank'}" + ' - ' + "#{person[i].get 'suit'}" + "</li>"
      i++
    return htmlOutput += '</ul>'

  getScore: (person) ->
    i = 0
    score = 0
    while i < person.length
      score += person[i].get 'rank'
      i++
    return score

  ###
    Give the player another card. If the player has 21, they lose. If they have
    21 points exactly, they win and if they have less than 21 points they can decide
    to hit or stand again.
  ###
  checkGameStatus: ->

    dealerScore = @getScore(@dealer)
    playerScore = @getScore(@player)

    console.log "Dealer score:"
    console.log dealerScore
    console.log "Player Score:"
    console.log playerScore
    
    if dealerScore < 18 and @player.length > 2
      @hitDealer()
    else if dealerScore > 21
      @gameOver(true)
    else if playerScore is 21 and dealerScore is 21
      @gameOver(false)

    if playerScore > 21
      @gameOver(false)
    else if playerScore is 21
      @gameOver(true)

  gameOver: (status) ->
    if (status)
      @.$('.final-result').append "<h2>You Win</h2>"
    else
      @.$('.final-result').append "<h2>You Lose</h2>"

  hit: ->
    @player.push @collection.pop()
    @checkGameStatus()
    @render()

  hitDealer: ->
    @dealer.push @collection.pop()
    @checkGameStatus()
    @render()

  ###
    Reveal the dealer's face down card. Give the dealer cards until they have 17
    points or more. If the dealer has over 21 points or the player has more points
    than the dealer (but less than 21), the player wins. 
  ###
  stand: ->
    @checkGameStatus()
