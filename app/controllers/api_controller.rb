class ApiController < ActionController::API
  def test
    render json: { message: "Hello, World!" }
  end
end
