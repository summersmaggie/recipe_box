require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:home)
end

get('/recipes/new') do
  erb(:recipe_form)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

post('/recipes') do
  title = params.fetch("title")
  instructions = params.fetch("instructions")
  recipe = Recipe.create({:title => title, :instructions => instructions})
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @recipe.ingredients
  erb(:recipe)
end

post('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  found_ingredient = Ingredient.find(params.fetch("ingredient_id"))
  @recipe.ingredients.push(found_ingredient)
  @recipe.ingredients
  erb(:recipe)
end

get('/ingredients/new') do
  erb(:ingredient_form)
end

get('/ingredients') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

post('/ingredients') do
  name = params.fetch("name")
  ingredient = Ingredient.create({:name => name})
  @ingredients = Ingredient.all()
  erb(:ingredients)
end
