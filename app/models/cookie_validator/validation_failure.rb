class CookieValidator
  class ValidationFailure
    def self.something_went_wrong(message)
      ValidationFailure.new(:something_went_wrong, :internal_server_error, message)
    end

    def self.session_cookie_expired(session_id)
      message = "session_start_time cookie for session \"#{session_id}\" has expired"
      ValidationFailure.new(:cookie_expired, :bad_request, message)
    end

    def self.no_cookies
      message = "No session cookies can be found"
      ValidationFailure.new(:no_cookies, :forbidden, message)
    end

    def self.cookies_missing(cookies)
      message = "The following cookies are missing: [#{cookies.join(', ')}]"
      ValidationFailure.new(:something_went_wrong, :internal_server_error, message)
    end

    def initialize(type, status, message)
      @type = type
      @status = status
      @message = message
    end

    attr_reader :type, :status, :message

    def ok?
      false
    end
  end
end
