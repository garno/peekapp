module Peekapp

  module Reviews

    def self.from_app id, options = {} # {{{
      [Review.new]
    end # }}}

  end

  class Review
    include Reviews

  end

end
