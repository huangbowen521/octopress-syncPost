octopress-syncPost V2.0
==================

A octopress plugin to sync the latest post to a website which suport MetaWeblog. (Wordpress, CSDN, CNBlogs,BlogBus etc.)


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

3. Copy metaweblog.yml to your octopress folder and change configuration in it. (**Please note: never check in this file to git due to security issue. **)

	```xml

	# MetaWeblog
	blogName:
	MetaWeblog_username: *YOURUSERNAME*
	MetaWeblog_password: *YOURPASSWORD*
	MetaWeblog_url: *YOURBLOGMETAWEBLOGURL*
	MetaWeblog_blogid: *BlogID*  //can be any number

	``` 
It supports multiple websites. There are examples in the file.

	```xml

#MetaWeblog
Cnblogs:
  MetaWeblog_username: <yourname>
  MetaWeblog_password: <yourpassword>
  MetaWeblog_url: http://www.cnblogs.com/<yourname>/services/metaweblog.aspx
  MetaWeblog_blogid: 145005
# SINA:
#   MetaWeblog_username: huangbowen521@126.com
#   MetaWeblog_password: 111111111
#   MetaWeblog_url: http://upload.move.blog.sina.com.cn/blog_rebuild/blog/xmlrpc.php
#   MetaWeblog_blogid: 200000
# 163blog:
#   MetaWeblog_username: huangbowen521@126.com
#   MetaWeblog_password: 111111111
#   MetaWeblog_url: http://os.blog.163.com/api/xmlrpc/metaweblog/
#   MetaWeblog_blogid: 200001

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