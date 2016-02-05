class StartController < ApplicationController
  def index
    validation = CookieValidator.new.validate(cookies)
    if validation.ok?
      render "index"
    elsif validation.no_cookies?
      render "no_cookies"
    else
      render "something_went_wrong"
    end
  end
end
