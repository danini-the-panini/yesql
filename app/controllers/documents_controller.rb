class DocumentsController < AuthenticatedController
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new(body: {})
  end

  def create
    @document = Document.new(title: params[:title], body: params[:body])

    if @document.save
      redirect_to @document
    else
      render :new
    end
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

    if @document.save
      redirect_to @document
    else
      render :edit
    end
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
