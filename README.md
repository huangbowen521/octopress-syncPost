octopress-syncPost
==================

A octopress plugin to sync the latest post to a website which suport MetaWeblog. (Wordpress, CSDN, CNBlogs,BlogBus etc.)

中文介绍请看这里: <http://huangbowen.net/blog/2013/04/14/octopress-plugin-to-sync-post/>

## Configure

1. Checkout this repository, **copy _custom folder(contains the file in it) to your octopress folder.**

2. add new gem denpendencies to Gemfile.

	```ruby
	  gem 'metaweblog', '~> 0.1.0'
	  gem 'nokogiri', '~> 1.5.9'
	```
	(The first gem is used to send post with MetaWeblog API.
	The second gem is used to parse html.)

	then run `bundle install` to install them.

3. add MetaWeblog configuration to _config.yml file.

	```xml

	# MetaWeblog
	MetaWeblog_username: *YOURUSERNAME*
	MetaWeblog_password: *YOURPASSWORD*
	MetaWeblog_url: *YOURBLOGMETAWEBLOGURL*
	MetaWeblog_blogid: *BlogID*  //can be any number

	``` 
There is a example for [cnblogs] config.

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

1. run `rake generate` to generate sites.

2. run `rake sync_post` to sync the latest post to your website.

**Please note:** 

1. Check the image url in your post, to fix the image url issue.

2. Some website require you enable MetaWeblog features in the dashboard. (ect. [cnblogs])

## How to keep same styling

Use [cnblogs] as a example.

1. use file uploader in cnblogs dashboard to upload screen.css file in your octopress project.

2. config the '页首html代码' in cnblogs dashboard to use the screen.css file.


## Some websites which support MetaWeblog API.

* Wordpress

	If your WordPress root is http://example.com/wordpress/, then you have:
	Server: http://example.com/ (some tools need just the 'example.com' hostname part)
	Path: /wordpress/xmlrpc.php
	complete URL (just in case): http://example.com/wordpress/xmlrpc.php

* 51CTO.com

	URL：http://<yourBlogUrl>/xmlrpc.php（example: http://magong.blog.51cto.com/xmlrpc.php）

* 博客大巴

	URL：http://www.blogbus.com/<accountName>/app.php（example: http://www.blogbus.com/holly0801/app.php

* CSDN

	URL：http://hi.csdn.net/<accountName>/services/metablogapi.aspx（example: http://hi.csdn.net/bvbook/services/metablogapi.aspx）

* 博客园

	URL：http://www.cnblogs.com/<accountName>/services/metaweblog.aspx（example: http://www.cnblogs.com/bvbook/services/metaweblog.aspx）

* 网易

	URL: http://<accountName>.blog.163.com/ (example: http://huang0925.blog.163.com/).

[cnblogs]: http://www.cnblogs.com/