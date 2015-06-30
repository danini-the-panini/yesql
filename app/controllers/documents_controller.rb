class DocumentsController < AuthenticatedController
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new(body: {})
  end

  def create
    @document = Document.create(title: params[:title], body: params[:body])

    redirect_to @document
  end

  def show
    find_document
  end

  def edit
    find_document
  end

  def update
    find_document
    @document.title = params[:title]
    @document.body = params[:body]
    @document.save!

    redirect_to @document
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
