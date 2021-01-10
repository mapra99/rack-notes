require 'spec_helper'
require 'rack/test'
require 'status_checker'

describe StatusCheckerApplication do
  include Rack::Test::Methods
  def app
    StatusCheckerApplication.new
  end

  it 'works!' do
    get '/'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq('ok')
  end
end
