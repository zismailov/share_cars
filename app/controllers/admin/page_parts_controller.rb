class Admin::PagePartsController < BaseController
  before_filter :load_page_part, only: %i[show edit update delete]

  def index
    @page_parts = Cms::PagePart.all
  end

  def show; end

  def new
    @page_part = Cms::PagePart.new
  end

  def create
    @page_part = Cms::PagePart.new(page_part_params)
    if @page_part.save
      redirect_to admin_page_parts_url, notice: "Content created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @page_part.update_attributes(page_part_params)
      redirect_to admin_page_parts_url, notice: "The changes have been saved."
    else
      render :edit
    end
  end

  def delete
    @page_part.destroy
    redirect_to admin_page_parts_url, notice: "The content has been deleted."
  end

  private

  def load_page_part
    @page_part = Cms::PagePart.find(params[:id])
  end

  def page_part_params
    params.require(:page_part).permit(:name, :title, :body)
  end
end
