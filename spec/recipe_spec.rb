require('spec_helper')

describe(Recipe) do
  it { should have_and_belong_to_many(:ingredients) }
end

describe(Recipe) do
  it("ensures the name is valid") do
    recipe = Recipe.new({:title => " "})
    expect(recipe.save()).to(eq(false))
  end
  it("ensures the ingredients are valid") do
    recipe = Recipe.new({:instructions => " "})
    expect(recipe.save()).to(eq(false))
  end
end
