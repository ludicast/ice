(function() {
  var Dish, Meal, Money;
  var __slice = Array.prototype.slice;
  window.Dish = Dish = (function() {
    function Dish(rawDescription) {
      var all, _ref;
      _ref = this.parseRawDescription(rawDescription), all = _ref[0], this.title = _ref[1], this.price = _ref[2], this.tag = _ref[3];
      this.price = new Money(this.price);
    }
    Dish.prototype.parseRawDescription = function(rawDescription) {
      var pattern, r, result, _i, _len, _results;
      if (rawDescription == null) {
        rawDescription = '';
      }
      pattern = /([^\$]+)(\$\d+\.\d+)(.*)/;
      result = rawDescription.match(pattern);
      if (result) {
        _results = [];
        for (_i = 0, _len = result.length; _i < _len; _i++) {
          r = result[_i];
          _results.push(r.trim());
        }
        return _results;
      } else {
        return ['', rawDescription, '', ''];
      }
    };
    Dish.prototype.toJSON = function() {
      return {
        title: this.title,
        price: this.price.toString()
      };
    };
    return Dish;
  })();
  window.Money = Money = (function() {
    function Money(rawString) {
      this.cents = this.parseCents(rawString);
    }
    Money.prototype.parseCents = function(rawString) {
      var cents, dollars, _ref, _ref2;
      if (rawString == null) {
        rawString = "";
      }
      _ref2 = (_ref = rawString.match(/(\d+)/g)) != null ? _ref : [0, 0], dollars = _ref2[0], cents = _ref2[1];
      if (cents > 99) {
        cents = 99;
      }
      return +cents + 100 * dollars;
    };
    Money.prototype.toString = function() {
      return "$" + (Math.floor(this.cents / 100)) + "." + (this.cents % 100);
    };
    return Money;
  })();
  window.Meal = Meal = (function() {
    function Meal() {
      this.dishes = [];
    }
    Meal.prototype.add = function() {
      var dishes, _ref;
      dishes = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return (_ref = this.dishes).push.apply(_ref, dishes);
    };
    Meal.prototype.totalPrice = function() {
      var dish, total, _i, _len, _ref;
      total = new Money;
      _ref = this.dishes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        dish = _ref[_i];
        total.cents = total.cents + dish.price.cents;
      }
      return total;
    };
    Meal.prototype.toJSON = function() {
      var dish;
      return {
        dishes: (function() {
          var _i, _len, _ref, _results;
          _ref = this.dishes;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            dish = _ref[_i];
            _results.push(dish.toJSON());
          }
          return _results;
        }).call(this),
        price: this.totalPrice().toString()
      };
    };
    return Meal;
  })();
}).call(this);
