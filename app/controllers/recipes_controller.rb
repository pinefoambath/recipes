class RecipesController < ApplicationController
  def index
    recipes = HTTP.get('https://raw.githubusercontent.com/raywenderlich/recipes/master/Recipes.json').to_s
    @all_recipes = JSON.parse(recipes)
    create_recipes(@all_recipes)
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def create_recipes(recipes_hash)
    recipes_hash.each do |recipe|
      ingredients = recipe['ingredients'].join(', ')
      steps = recipe['steps'].join(', ')
      Recipe.find_or_initialize_by(name: recipe['name']).update(ingredients:, steps:)
    end
  end
end
