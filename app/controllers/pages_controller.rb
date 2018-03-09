class PagesController < ApplicationController
  skip_before_action :require_login

  def terms
  end

  def about
  end
end
