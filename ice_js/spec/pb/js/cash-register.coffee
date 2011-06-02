
window.Dish = class Dish
  constructor: (rawDescription) ->
    [all, @title, @price, @tag] = @parseRawDescription rawDescription
    @price = new Money @price

  parseRawDescription: (rawDescription='') ->
    pattern = ///
      ([^\$]+)      # Title
      (\$\d+\.\d+) # Dollar Amount
      (.*)       # Tag
    ///
    result = rawDescription.match pattern
    if result
      r.trim() for r in result
    else
      ['', rawDescription, '', '']

  toJSON: ->
    title: @title
    price: @price.toString()


window.Money = class Money
  constructor: (rawString) ->
    @cents = @parseCents rawString

  parseCents: (rawString="") ->
    [dollars, cents] = rawString.match(/(\d+)/g) ? [0,0]
    cents = 99 if cents > 99
    +cents + 100*dollars

  toString: ->
    "$#{Math.floor(@cents / 100)}.#{@cents % 100}"


window.Meal = class Meal
  constructor: ->
    @dishes = []

  add: (dishes...) -> @dishes.push dishes...

  totalPrice: ->
    total = new Money
    total.cents = total.cents + dish.price.cents for dish in @dishes
    total

  toJSON: ->
    dishes: dish.toJSON() for dish in @dishes
    price: @totalPrice().toString()

