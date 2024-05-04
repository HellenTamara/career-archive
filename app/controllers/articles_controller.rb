class ArticlesController < ApplicationController
  def index
    @articles = current_user.articles
    @articles_list = current_user.articles
    if params[:start_date].present?
      @articles_list = Article.where(date: params[:start_date]..params[:end_date], user_id: current_user.id)
    end
  end

  def create_summary
    @articles = current_user.articles
    @articles_list = @articles

    if params[:start_date].present?
      @articles_list = @articles.where(date: params[:start_date]..params[:end_date])
    end

    # Initialize an empty string to store the text content from all articles
    text_to_summarize = ""

    # Iterate through each article in @articles_list
    @articles_list.each do |article|
      rich_text = ActionText::RichText.find_by(record_id: article.id, record_type: 'Article', name: 'content')

      # Check if rich_text exists before processing
      if rich_text.present? && rich_text.body.present?
        # Extract text content and remove HTML tags
        text_to_summarize += ActionController::Base.helpers.strip_tags(rich_text.body.to_plain_text)
      else
        # Handle the case where rich_text or rich_text.body is nil
        # You can log this event or handle it in any appropriate way
        Rails.logger.warn("RichText not found or empty for article ID: #{article.id}")
      end
    end

    # Use OpenAI to generate a summary
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Generate a summary of the user's achievements, numbers, and progress: #{text_to_summarize}"}]
    })

    @summary = chaptgpt_response["choices"][0]["message"]["content"]

    render turbo_stream: turbo_stream.replace(
      'summary-container',
      partial: 'summary',
      locals: { summary: @summary }
    )
  end


  def show
    @article = Article.find(params[:id])
    @objectives = Objective.all.where(user_id: current_user.id)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params_filtered)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params_filtered)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other
  end

  private

  def params_filtered
    params.require(:article).permit(:title, :content,:date, :start_date, :end_date, photos:[] )
  end
end
