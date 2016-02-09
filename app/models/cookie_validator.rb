class CookieValidator
  def validate(cookies)
    if all_cookies_missing?(cookies)
      NoCookiesValidation.new
    elsif 
      MissingCookiesValidation.new(missing_cookies)
    else
      Validation.new
    end
    [@no_cookies_validator, @missing_cookies_validator].lazy.map { |validator| validator.validate(cookies) }.detect({ |result| !result.ok? }) || Validation.new
  end

  def all_cookies_missing?(cookies)
    cookies.select { |name, _| CookieNames.session_cookies.include?(name) }.empty?
  end

  class NoCookieValidator
    def validate(cookies)
      if cookies.select { |name, _| CookieNames.session_cookies.include?(name) }.empty?
        NoCookiesValidation.new
      else
        Validation.new
      end
    end
  end

  class MissingCookiesValidatior
    def validate(cookies)
    end

    def message
      @result.message
    end
  end

  class Validation
    def no_cookies?
      false
    end

    def ok?
      true
    end
  end

  class NoCookiesValidation
    def no_cookies?
      true
    end

    def ok?
      false
    end

    def message
      "No session cookies can be found"
    end
  end
end
