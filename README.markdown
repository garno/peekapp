Retrieve reviews and ratings from the App Store.

# Installation
    gem install peekapp

## How to

For advanced functionnalities you should read the source. Peekapp can only retrieve ratings & reviews from the Canadian App Store.

    require "peekapp"

    # Get the App
    app = Peekapp::Apps::find 390574988 # App ID

    # Get reviews for this App
    app.reviews
    # => [#<Review:0x102237a28 @data={
    #       :title    => "Amazing",
    #       :comment  => "Best Twitter app on the face of the planet!",
    #       :username => "Thomas Gallagher",
    #       :rating   => 5,
    #       :user_id  => 33308895,
    #       :version  => "2.0",
    #       :date     => "9-Oct-2009",
    #       :id       => Digest::SHA256.new("title + username")
    #    }>, ...]

    # And the ratings...
    app.ratings
    # => [#Rating:0x1029372a23 @data={
    #      :current => { "1": 38, "2": 12, "3": 23, "4": 25, "5": 105 },
    #      :all     => { "1": 2736, "2": 749, "3": 1045, "4": 1103, "5": 3880 },
    #      :store_id => "143455-5,12"
    #    }>, ...]

## Warning
Since Peekapp is **scraping** the App Store, you might experience some problems if Apple change iTunes' html layout. I've made some tests and the App Store is updated every 20 minutes (*ballpark*). So don't waste your time trying to get *real time* ratings & reviews.

## Todo
  - Create unit tests w/ [FakeWeb](https://github.com/chrisk/fakeweb)
  - Allow international App Stores
  - iTunes Connect support
