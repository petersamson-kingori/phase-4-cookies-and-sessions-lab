class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :set_page_views

  def show
    if session[:page_views].to_i <= 3
      render json: article_data(params[:id])
    else
      render json: { error: "Maximum pageview limit reached" }, status: :unauthorized
    end
  end

  private

  def set_page_views
    session[:page_views] ||= 0
    session[:page_views] += 1
  end

  def article_data(id)
    article = Article.find(id)
    {
      id: article.id,
      title: article.title,
      minutes_to_read: article.minutes_to_read,
      author: article.user.username,
      content: article.content
    }
  end
end
