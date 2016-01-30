# RScratch

![Rscratch with its Web UI](http://rscratch.github.io/rscratch_logo.pn)

## Installation

Add this line to your application's Gemfile:
```ruby
  gem 'rscratch'
```
And then execute:
```ruby
  $ bundle install
```
Or install it yourself as:
```ruby
  $ gem install rscratch
```
After you install RScratch, you need to run the generator:
```ruby
  $ rails g rscratch:install
```

The generator will create few migration files, a initializer file, and routes to access Rscratch WebUI. It is imperative that you take a look at it. When you are done, you are ready to run migration using the following command:
```ruby
  $ rake db:migrate
```
You should restart your application after installing RScratch gem.

## Usage
Add this following line in rescue block of your your code. An example is given below
```ruby
  Rscratch::Exception.log e,request
```

An example is given below

```ruby
  def create
    begin
      @post = Post.new(params[:post])
      @post.save
      respond_to do |format|
        format.json { render json: @post, status: :created, location: @post }
      end      
    rescue Exception => e
      # Log exception in RScratch
      Rscratch::Exception.log e,request
      
      respond_to do |format|
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end            
    end
  end
```

## WebUI
Now everything looks sparky. Rscratch comes bundled with a web UI to track exceptions raised from your application. Go to the following URL to access it.

  http://{YOUR_APP_URL}/rscratch/

Ohh!! you may be asked for username and password once you visit this page. These credentials are by default set in the initializer file. 
```ruby
  username: admin 
  password: admin123
```
To change this credentials check rsctarch initializer file in the following directory
```ruby
  config/initializers/rscratch.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/avishekjana/rscratch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

