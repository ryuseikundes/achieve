class PoemsController < ApplicationController

  def index
    @poems = Poem.all
  end

  def show
    @poem = Poem.find(:all)
  end


end
