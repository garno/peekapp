module Peekapp

  module Ratings

    def self.from_app id, stores, options = {} # {{{
      rating = Array.new
      stores.each do |s|
        rating << parse({
          :dom => Peekapp::query({
            :url => $peekapp_config[:ratings_url],
            :page => 1,
            :app_id => id,
            :store_id => s,
            :app_version => (options[:app_version] ? options[:app_version] : "all")
          }),
          :store_id => s
        })
      end
      rating
    end # }}}

    def self.parse data # {{{
      rating = Rating.new :store_id => data[:store_id]
      dom = Nokogiri::HTML.parse(data[:dom])
      nb_ratings_section = dom.css("div.ratings-histogram").count

      dom.css("div.ratings-histogram").each_with_index do |r,i|
        data = Hash.new
        result = true
        r.css("div.vote").each_with_index{ |v,j| data.merge!({(5-j) => v.css("span.total").children.to_s.to_i }) }

        if nb_ratings_section === 1 or i === 1
          rating.set :key => :all, :value => data
          rating.set :key => :current, :value => data if nb_ratings_section === 1
        else
          rating.set :key => :current, :value => data
        end
      end

      rating.set :key => :all, :value => {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0} if nb_ratings_section < 1
      rating
    end # }}}

  end

  class Rating

    attr_accessor :data

    def initialize data # {{{
      @data = data
    end # }}}

    def id # {{{
      @data[:id]
    end # }}}

    def set args # {{{
      @data.merge!({args[:key] => args[:value]})
    end # }}}

    def method_missing method # {{{
      @data[method.to_sym]
    end # }}}

  end

end
