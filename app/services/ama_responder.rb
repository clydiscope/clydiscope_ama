require "net/http"
require "json"

class AmaResponder

    def initialize(prompt)
        @prompt = prompt
        
    end

    def call
        ask_qwen
    
    end

    private

    def ask_qwen
        uri = URI("http://127.0.0.1:1234/api/v1/chat")
        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request.body = {model: "qwen/qwen3-1.7b", input: @prompt}.to_json
        response = Net::HTTP.start(uri.hostname,uri.port) do |http|
            http.request(request)
        end
        data = JSON.parse(response.body)
        data["output"][1]["content"].strip
    end
end