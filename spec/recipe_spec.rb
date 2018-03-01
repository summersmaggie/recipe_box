require('spec_helper')

describe(Recipe) do
  it { should have_and_belong_to_many(:ingredients) }

  it("ensures the name is valid") do
    recipe = Recipe.new({:title => " "})
    expect(recipe.save()).to(eq(false))
  end

  it("ensures the ingredients are valid") do
    recipe = Recipe.new({:instructions => " "})
    expect(recipe.save()).to(eq(false))
  end

  it("converts the title to titlecase") do
    recipe = Recipe.create({:title => "pizza sauce"})
    expect(recipe.titlecase_title()).to(eq("Pizza Sauce"))
  end

  it("converts the instructions to lowercase") do
    recipe = Recipe.create({:instructions => "ADD cheese"})
    expect(recipe.downcase_instructions()).to(eq("add cheese"))
  end
end
