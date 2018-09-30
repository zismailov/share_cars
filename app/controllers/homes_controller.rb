class HomesController < ApplicationController
  def index
    @page_part1 = Cms::PagePart.where(id: 1)
    @search = Search.new
  end
end
