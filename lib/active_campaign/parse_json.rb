module ActiveCampaign
  module ParseJson
    def parse_json(json)
      JSON.parse(json)
    rescue JSON::ParseError
      {"result_code":0,"result_message":"Invalid JSON in response"}
    end
  end
end
