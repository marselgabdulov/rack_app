# frozen_string_literal: true

require 'rack'
require_relative 'lib/time_formatter'

class App
  def call(env)
    request = Rack::Request.new(env)

    route_request(request)
  end

  private

  def route_request(request)
    case request.path
    when '/time'
      formatter_response(request)
    else
      not_found_response
    end
  end

  def formatter_response(request)
    formatter = TimeFormatter.new(request.params['format'])

    formatter.valid? ? response(status: 200, body: formatter.result) : response(status: 400, body: formatter.result)
  end

  def response(status:, body:, headers: { 'Content-Type' => 'text/plain' })
    [status, headers, [body]]
  end

  def not_found_response
    response(status: 404, body: '404 Not Found')
  end
end
