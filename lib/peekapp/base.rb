require "curb"
require "json"

$peekapp_config = YAML::load(File.open(File.dirname(__FILE__)+"/config/default.yml"))

module Peekapp

  def self.query args # {{{
    c = Curl::Easy.perform(parse_url(args)) do |request|
      request.headers["User-Agent"] = $peekapp_config[:user_agent]
      request.headers["X-Apple-Store-Front"] = args[:store_id] if args[:store_id]
    end

    c.body_str
  end # }}}

  def self.parse_url data # {{{
    url = data[:url]
    data.each_pair{|k,v| url = url.gsub("|#{k}|", v.to_s) if k != :url}
    url
  end # }}}
end
