require('spec_helper')

describe(Ingredient) do
  it { should have_and_belong_to_many(:recipes) }

  it("ensures the ingredient is valid") do
    ingredient = Ingredient.new({:name => " "})
    expect(ingredient.save()).to(eq(false))
  end
end
