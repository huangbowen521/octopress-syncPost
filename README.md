octopress-syncPost
==================

A octopress plugin to sync the latest post to a website which suport MetaWeblog. (Wordpress, CSDN, CNBlogs,BlogBus etc.)

## Configure

1. Checkout this repository. copy _custom folder(contains the file in it) to your octopress folder.

2. add new gem denpendencies to Gemfile.

	```ruby

	  gem 'metaweblog', '~> 0.1.0'
	  gem 'nokogiri', '~> 1.5.9'

	```
(The first gem is used to send post with MetaWeblog API.
The sencend gem is used to parse html.)

then run `bundle install` to install them.

3. add MetaWeblog configuration to _config.yml file.

	```xml

	# MetaWeblog
	MetaWeblog_username: *YOURUSERNAME*
	MetaWeblog_password: *YOURPASSWORD*
	MetaWeblog_url: *YOURBLOGMETAWEBLOGURL*
	MetaWeblog_blogid: *BlogID*  //can be any number

	``` 
There is a example for CNBlogs config.

	```xml

	# MetaWeblog
	MetaWeblog_username: huang0925
	MetaWeblog_password: XXXXXXXXXX
	MetaWeblog_url: http://www.cnblogs.com/huang0925/services/metaweblog.aspx
	MetaWeblog_blogid: 145005

	```

4. add this task to Rakefile.

	```ruby

	desc "sync post to MetaWeblog site"
	task :sync_post do
	  puts "Sync the latest post to MetaWeblog site"
	  system "ruby _custom/sync_post.rb"
	end

	```

## Usage

1. run `rake generate` to generate files to public floder.

2. run `rake sync_post` to sync the latest post to your another website.


