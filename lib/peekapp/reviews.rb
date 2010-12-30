module Peekapp

  module Reviews

    def self.from_app id, stores, options = {} # {{{
      reviews = Array.new
      begin
        stores.each do |s|
          args = {:url => $peekapp_config[:reviews_url],
                  :app_id => id,
                  :store_id => s,
                  :page => 1,
                  :app_version => "all"}
          dom = Peekapp::query args
          nb_page = Nokogiri::HTML.parse(dom).css("div.paginated-content").first["total-number-of-pages"].to_i
          nb_page.times do |z|
            # dom is already instanciated for z === 0
            args[:page] = z+1
            dom = Peekapp::query args if z > 0
            parse(dom).each do |p|
              raise LatestReviewReached if p.id === args[:latest_review_id].to_s
              reviews << p
            end
          end
        end
      rescue LatestReviewReached
        # Do nothing... just get out !
      end
      reviews
    end # }}}

    def self.parse data # {{{
      reviews = Array.new
      dom = Nokogiri::HTML.parse(data)
      dom.css("div.customer-review").each do |r|
        # That's some ugly stuff... I know
        reviews << Review.new({
          :id          => r.css("a.report").first["href"].split("=").last,
          :title       => r.css("span.customerReviewTitle").children.to_s,
          :comment     => r.css("p.content").children.to_s.gsub("\n", "").gsub("  ", ""),
          :username    => r.css("a.reviewer").children.to_s.gsub("\n", "").gsub(" ", ""),
          :user_id     => r.css("a.reviewer").first["href"].split('=').last,
          :rating      => r.css("div.rating").first['aria-label'].split(' ').first.to_i,
          :date        => r.css("span.user-info").children.to_s.split(" -\n").last.gsub("\n", "").gsub(" ", ""),
          :version     => r.css("span.user-info").children.to_s.split(" -\n")[1].split(" - ").first.split(" ").last.to_s,
        })
      end
      reviews
    end # }}}

  end

  class Review
    include Reviews

    def initialize data # {{{
      @data = data
    end # }}}

    def id # {{{
      @data[:id]
    end # }}}
  end

end
