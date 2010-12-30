module Peekapp

  module Apps

    def self.search query, options = {} # {{{
    end # }}}

    def self.find id # {{{
      result = JSON.parse(Peekapp::query :url => $peekapp_config[:app_url], :app_id => id)
      raise AppNotFound if result["resultCount"] < 1
      result["results"].map{|a| App.new a}.first
    end # }}}

    def ratings options={} # {{{
      Peekapp::Ratings.from_app self.id, options
    end # }}}

    def reviews options={} # {{{
      self._reviews = Peekapp::Reviews.from_app self.id, ["143455-5,12"], options if self._reviews.nil? or options[:force_refresh]
      self._reviews
    end # }}}

    # TODO => Create these exception classes automatically
    self.module_eval("AppNotFound = Class.new(StandardError)")
  end

  class App
    include Apps

    attr_accessor :_reviews

    def initialize data # {{{
      @data = data
    end

    def id # {{{
      @data["trackId"]
    end # }}}
    # }}}
  end

end
