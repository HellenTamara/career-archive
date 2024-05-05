class EntriesController < ApplicationController
  def index
    @entries = current_user.entries
    @entries_list = current_user.entries
    if params[:start_date].present?
      @entries_list = Entry.where(date: params[:start_date]..params[:end_date], user_id: current_user.id)
    end
  end

  def create_summary
    @entries = current_user.entries
    @entries_list = @entries

    if params[:start_date].present?
      @entries_list = @entries.where(date: params[:start_date]..params[:end_date])
    end

    # Initialize an empty string to store the text content from all entries
    text_to_summarize = ""

    # Iterate through each entry in @entries_list
    @entries_list.each do |entry|
      rich_text = ActionText::RichText.find_by(record_id: entry.id, record_type: 'Entry', name: 'content')

      # Check if rich_text exists before processing
      if rich_text.present? && rich_text.body.present?
        # Extract text content and remove HTML tags
        text_to_summarize += ActionController::Base.helpers.strip_tags(rich_text.body.to_plain_text)
      else
        # Handle the case where rich_text or rich_text.body is nil
        # You can log this event or handle it in any appropriate way
        Rails.logger.warn("RichText not found or empty for entry ID: #{entry.id}")
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
    @entry = Entry.find(params[:id])
    @objectives = Objective.all.where(user_id: current_user.id)
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(params_filtered)
    @entry.user = current_user
    if @entry.save
      redirect_to entry_path(@entry)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(params_filtered)
      redirect_to entry_path(@entry)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path, status: :see_other
  end

  private

  def params_filtered
    params.require(:entry).permit(:title, :content,:date, :start_date, :end_date, photos:[] )
  end
end
