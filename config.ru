require './autoload'

app = Rack::Builder.new do
  use Middlewares::Racker
end

run app
