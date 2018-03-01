require("bundler/setup")
require('pry')
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
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  @tags = Tag.all()
  erb(:recipe)
end


post('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  found_ingredient = Ingredient.find(params.fetch("ingredient_id").to_i)
  @recipe.ingredients.push(found_ingredient)
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  @tags = Tag.all()
  erb(:recipe)
end #add ingredient button

post('/recipes/:id/tags') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  found_tag = Tag.find(params.fetch("tag_id").to_i)
  @recipe.tags.push(found_tag)
  @tags = Tag.all()
  @recipes = Recipe.all()
  erb(:recipe)
end #add category button

get('/recipes/:id/edit') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:edit_recipe)
end

patch('/recipes/:id') do
  title = params.fetch("title")
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.update({:title => title})
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  erb(:recipe)
end

delete('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.delete()
  @recipes = Recipe.all()
  erb(:recipes)
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

get('/ingredients/:id')do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  erb(:ingredient)
end

patch('/ingredients/:id') do
  name = params.fetch("name")
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  @ingredient.update({:name => name})
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

delete('/ingredients/:id') do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  @ingredient.delete()
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

get('/tags/new') do
  erb(:tag_form)
end

post('/tags') do
  category = params.fetch("category")
  tag = Tag.create({:category => category})
  @tags = Tag.all
  erb(:tags)
end

get('/tags/:id')do
  @tag = Tag.find(params.fetch("id").to_i)
  erb(:tag)
end

patch('/tags/:id') do
  category = params.fetch("category")
  @tag = Tag.find(params.fetch("id").to_i)
  @tag.update({:category => category})
  @tags = Tag.all()
  erb(:tags)
end

delete('/tags/:id') do
  @tag = Tag.find(params.fetch("id").to_i)
  @tag.delete()
  @tags = Tag.all()
  erb(:tags)
end

get('/tags') do
  @tags = Tag.all
  erb(:tags)
end
