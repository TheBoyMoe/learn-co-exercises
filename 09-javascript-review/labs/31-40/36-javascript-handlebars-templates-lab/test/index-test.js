describe('Handlebars Templates Lab', function() {
  describe('page', function() {
    before(function() {
      init()
    })

    it('has a recipe form', function() {
      var recipeForm = document.getElementById("recipe-form")
      expect(recipeForm).toExist("Must provide a form with an id of 'recipe-form'")
      expect(recipeForm).toMatch(/onsubmit="createRecipe()"/)
      var ingredients = document.getElementsByName("ingredients")
      expect(ingredients.length).toBeGreaterThanOrEqualTo(5)
      var nameField = document.getElementById("name")
      expect(nameField).toExist()
    })
  })

  describe('templates', function() {
    it('has a recipe template', function() {
      var recipeTemplate = document.getElementById("recipe-template")
      expect(recipeTemplate).toExist("Must provide a template with an id of 'recipe-template'")
      expect(recipeTemplate.type).toBe("text/x-handlebars-template", "Template must be of type text/x-handlebars-template")
      expect(recipeTemplate.innerHTML).toMatch(/{{\s?name\s?}}/)
      expect(recipeTemplate.innerHTML).toMatch(/<a.*displayEditForm().*>Edit Recipe<\/a>/, "Template must have an 'Edit Recipe' link that calls 'displayEditForm()'")
      expect(recipeTemplate.innerHTML).toMatch(/{{>\s?recipeDetailsPartial\s?}}/, "Template must render the recipeDetailsPartial")
    })
    it('has a recipe details partial template', function() {
      var recipeDetailsPartial = document.getElementById("recipe-details-partial")
      expect(recipeDetailsPartial).toExist("Must provide a template with an id of 'recipe-details-partial'")
      expect(recipeDetailsPartial.type).toBe("text/x-handlebars-template", "Template must be of type text/x-handlebars-template")
      expect(recipeDetailsPartial.innerHTML).toMatch(/{{\s?description\s?}}/)
      expect(recipeDetailsPartial.innerHTML).toMatch(/{{\s?#each ingredients\s?}}/)
      expect(recipeDetailsPartial.innerHTML).toMatch(/{{\s?displayIngredient this\s?}}/, "Template must make use of displayIngredient custom helper inside the #each block helper")
    })
    it('has a recipe form template', function() {
      var recipeFormTemplate = document.getElementById("recipe-form-template")
      expect(recipeFormTemplate).toExist("Must provide a template with an id of 'recipe-form-template'")
      expect(recipeFormTemplate.type).toBe("text/x-handlebars-template", "Template must be of type text/x-handlebars-template");
    })
  })

  describe('helpers and partials', function() {
    before(function() {
      init()
    })

    it('registers a displayIngredient helper', function() {
      expect(window.Handlebars.helpers).toContainKey("displayIngredient")
    })

    it('registers a recipe details partial', function() {
      expect(window.Handlebars.partials).toContainKey("recipeDetailsPartial")
    })

    it('registers a recipe form partial', function() {
      expect(window.Handlebars.partials).toContainKey("recipeFormPartial")
    })
  })

  describe('functions', function() {
    before(function() {
    })

    describe('displayEditForm', function() {
      it('renders the edit form template', function() {
        init()
        createRecipe()
        var spy = expect.spyOn(window.Handlebars, "compile").andCallThrough()
        displayEditForm()
        expect(spy).toHaveBeenCalledWith(document.getElementById("recipe-form-template").innerHTML)
        spy.reset()
      })
    })

    describe('createRecipe', function() {
      it('renders the recipe template', function() {
        init()
        var spy = expect.spyOn(window.Handlebars, "compile").andCallThrough()
        createRecipe()
        expect(spy).toHaveBeenCalledWith(document.getElementById("recipe-template").innerHTML)
        spy.reset()
      })
    })

    describe('updateRecipe', function() {
      it('renders the recipe template', function() {
        init()
        var spy = expect.spyOn(window.Handlebars, "compile").andCallThrough()
        updateRecipe()
        expect(spy).toHaveBeenCalledWith(document.getElementById("recipe-template").innerHTML)
        spy.reset()
      })
    })
  })

});
