class CookieValidator
  def validate(cookies)
    Validation.new
  end

  class Validation
    def no_cookies?
      true
    end
  end

end
