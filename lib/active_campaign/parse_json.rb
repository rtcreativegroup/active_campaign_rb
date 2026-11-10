# frozen_string_literal: true

module ActiveCampaign
  module ParseJson
    EXCERPT_LENGTH = 120

    def parse_json(response)
      JSON.parse(response.body.to_s)
    rescue JSON::ParserError
      raise ActiveCampaign::InvalidJsonResponseError,
            "ActiveCampaign returned invalid JSON (HTTP #{response.code}): #{body_excerpt(response.body.to_s)}"
    end

    private

    def body_excerpt(body)
      excerpt = body.strip.gsub(/\s+/, ' ')
      return '(empty body)' if excerpt.empty?
      return excerpt if excerpt.length <= EXCERPT_LENGTH

      "#{excerpt[0, EXCERPT_LENGTH - 3]}..."
    end
  end
end
