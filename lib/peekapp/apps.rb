module Peekapp

  module Apps

    def self.search query # {{{
      result = JSON.parse(Peekapp::query(:url => $peekapp_config[:search_url], :keywords => query.gsub(' ', '%20')))
      result['results'].map { |a| App.new a }
    end # }}}

    def self.find id # {{{
      result = JSON.parse(Peekapp::query :url => $peekapp_config[:app_url], :app_id => id, :store_id => "143455-5,12")
      raise AppNotFound if result["resultCount"] < 1
      result["results"].map{|a| App.new a}.first
    end # }}}

    def ratings options={} # {{{
      self._ratings = Peekapp::Ratings.from_app self.id, ["143455-5,12"], options if self._ratings.nil? or options[:force_refresh]
      self._ratings
    end # }}}

    def reviews options={} # {{{
      self._reviews = Peekapp::Reviews.from_app self.id, ["143455-5,12"], options if self._reviews.nil? or options[:force_refresh]
      self._reviews
    end # }}}

  end

  class App
    include Apps

    attr_accessor :_reviews, :_ratings

    def initialize data # {{{
      @data = data
    end # }}}

    def id # {{{
      @data["trackId"]
    end # }}}

    def method_missing method # {{{
      @data[method.to_s]
    end # }}}

  end

end
