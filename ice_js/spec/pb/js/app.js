(function() {
  jQuery(function() {
    var meal, source, template;
    meal = new Meal;
    source = ($('#meal-template')).html();
    template = Handlebars.compile(source);
    ($('#entry')).focus();
    return ($('#entry_form')).submit(function(event) {
      var dish;
      event.preventDefault();
      dish = new Dish(($('#entry')).val());
      meal.add(dish);
      ($('ul#meal')).html(template(meal.toJSON()));
      return ($('#entry')).val('');
    });
  });
}).call(this);
