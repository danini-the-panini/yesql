class DocumentsController < AuthenticatedController
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
  end

  def show
    find_document
  end

  def edit
    find_document
  end

  def update
    find_document
  end

  def destroy
    find_document
    @document.destroy
  end

  private

  def find_document
    @document = Document.find(params[:id])
  end
end
