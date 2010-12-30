require "curb"
require "json"

module Peekapp

  def self.query args # {{{
    c = Curl::Easy.perform(parse_url(args)) do |request|
      request.headers["User-Agent"] = "iTunes/10.0.1 (Macintosh; Intel Mac OS X 10.6.4) AppleWebKit/533.18.1"
      request.headers["X-Apple-Store-Front"] = "15344-5,12"
    end

    c.body_str
  end # }}}

  def self.parse_url data # {{{
    url = data[:url]
    data.each_pair{|k,v| url = url.gsub("|#{k}|", v.to_s) if k != :url}
    url
  end # }}}
end
