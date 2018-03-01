require("bundler/setup")
require('pry')
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

##recipe
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
  @recipe = Recipe.new({:title => title, :instructions => instructions})
  if @recipe.save()
    redirect("/recipes")
  else
    erb(:errors)
  end
end

get('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  @tags = Tag.all()
  erb(:recipe)
end

get('/recipes/:id/edit') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  erb(:edit_recipe)
end

patch('/recipes/:id') do
  title = params.fetch("title")
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.update({:title => title})
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  redirect('/recipes')
end

delete('/recipes/:id') do
  @recipe = Recipe.find(params.fetch("id").to_i)
  @recipe.delete()
  redirect("/recipes")
end

##ingredients
get('/ingredients/new') do
  erb(:ingredient_form)
end

get('/ingredients') do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

get('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  @ingredients = Ingredient.all()
  erb(:ingredient)
end

post('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  found_ingredient = Ingredient.find(params.fetch("ingredient_id").to_i)
  @recipe.ingredients.push(found_ingredient)
  @available_ingredients = Ingredient.all() - @recipe.ingredients
  erb(:ingredient)
end #add ingredient button

post('/ingredients') do
  name = params.fetch("name")
  @ingredient = Ingredient.create({:name => name})
  if @ingredient.save()
    redirect('/ingredients')
  else
    erb(:errors)
  end
end

get('/ingredients/:id')do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  erb(:edit_ingredient)
end

patch('/ingredients/:id') do
  name = params.fetch("name")
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  @ingredient.update({:name => name})
  redirect('/ingredients')
end

delete('/ingredients/:id') do
  @ingredient = Ingredient.find(params.fetch("id").to_i)
  @ingredient.delete()
  redirect('/ingredients')
end

##tags
get('/tags/new') do
  erb(:tag_form)
end

get('/tags') do
 @tags = Tag.all
 erb(:tags)
end

post('/tags') do
  category = params.fetch("category")
  @tag = Tag.create({:category => category})
  if @tag.save()
    redirect("/tags")
  else
    erb(:errors)
  end
end

get('/tags/:id')do
  @tag = Tag.find(params.fetch("id").to_i)
  erb(:edit_tag)
end

get('/recipes/:id/tags') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @available_tags = Tag.all() - @recipe.tags
  @tags = Tag.all()
  erb(:tag)
end

post('/recipes/:id/tags') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  found_tag = Tag.find(params.fetch("tag_id").to_i)
  @recipe.tags.push(found_tag)
  @available_tags = Tag.all() - @recipe.tags
  @recipes = Recipe.all()
  erb(:tag)
end

patch('/tags/:id') do
  category = params.fetch("category")
  @tag = Tag.find(params.fetch("id").to_i)
  @tag.update({:category => category})
  redirect("/tags")
end

delete('/tags/:id') do
  @tag = Tag.find(params.fetch("id").to_i)
  @tag.delete()
  redirect("/tags")
end
