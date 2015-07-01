class DocumentsController < AuthenticatedController
  def index
    @documents = Document.all
    if not params[:title].blank?
      @documents = @documents.where('title ILIKE ?', "%#{params[:title]}%")
    end
    if not params[:body].blank?
      @documents = @documents.where("body ->> 'foo' ILIKE ?", "%#{params[:body][:foo]}%") unless params[:body][:foo].blank?
      @documents = @documents.where("body ->> 'bar' ILIKE ?", "%#{params[:body][:bar]}%") unless params[:body][:bar].blank?
    end
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
