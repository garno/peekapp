module Peekapp

  module Apps

    def self.search query, options = {} # {{{
    end # }}}

    def self.find id # {{{
      result = JSON.parse(Peekapp::query :url => $peekapp_config[:app_url], :app_id => id)
      raise AppNotFound if result["resultCount"] < 1
      result["results"].map{|a| App.new a}
    end # }}}

    def ratings options={} # {{{
      Peekapp::Ratings.from_app self.id
    end # }}}

    def reviews options={} # {{{
      Peekapp::Reviews.from_app self.id
    end # }}}

    # TODO => Create these exception classes automatically
    self.module_eval("AppNotFound = Class.new(StandardError)")
  end

  class App
    include Apps

    attr_accessor :id, :_reviews

    def initialize data # {{{
      @data = data
    end
    # }}}
  end

end
