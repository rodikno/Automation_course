require 'faraday'

module RedmineHelper

  def reset_hash(hash)
    hash.each_value{|value| value = nil}
  end

  def get_http_response_code(url)
    response = Faraday.get(url)
    response.status
  end

  def open_url_with_retries(url, retries_count)
    i = 0
    begin
      i += 1
      if is_http_get_response_positive?(url)
        return true
      end
    rescue StandardError
      if i < retries_count
        retry
      else
        return false
      end
    end
  end

  def is_http_get_response_positive?(url)
    positive_responses = 200..207
    status = get_http_response_code(url)
    if positive_responses.include? status
      true
    else
      raise StandardError, "HTTP Response for GET request for URL #{url} is not positive"
    end
  end

end