class Application
  def call(env)
    [200, {}, ["Hello from Rack"]]
  end
end

run Application.new
