require 'spec_helper'
require 'models/cookie_validator'

describe CookieValidator do
  it "will fail validation if there are no cookies" do
    validation = CookieValidator.new.validate({})
    expect(validation).to be_no_cookies
  end
end
