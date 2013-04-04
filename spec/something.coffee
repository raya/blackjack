describe "Something", ->
  
  it "should should be reasonable", ->
    expect(true).toBe(true)

  describe "Deck", ->
    beforeEach ->
      @deck = new window.CardCollection

    it "should have 52 cards", ->
      expect(@deck.length).toBe(52)

    it "should have 13 cards of each of the 4 suits", ->
      suits = ['Hearts', 'Clubs', 'Diamonds', 'Spades']
      for suit in suits
        numCards = @deck.filter (card) ->
          return card.get('suit') is suit
        expect(numCards.length).toBe(13)