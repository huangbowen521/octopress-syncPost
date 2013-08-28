octopress-syncPost V2.1
==================

A octopress plugin to sync the latest post to a website which suport MetaWeblog. (Wordpress, CSDN, CNBlogs,BlogBus etc.)


## Configure

1. Checkout this repository, **copy plugins/sync_post.rb to octopress/plugins/ folder.**

2. add new gem denpendencies to Gemfile.

	```ruby
	  gem 'metaweblog', '~> 0.1.0'
	  gem 'nokogiri', '~> 1.5.9'
	```
	(The first gem is used to send post with MetaWeblog API.
	The second gem is used to parse html.)

	then run `bundle install` to install them.

3. Add blogs configuration to the end of octopress/_config.yml

```xml
# MetaWeblog
MetaWeblog:
   blogName:
      MetaWeblog_username: *YOURUSERNAME*
      MetaWeblog_url: *YOURBLOGMETAWEBLOGURL*
      MetaWeblog_blogid: *BlogID*  //can be any number
      
``` 
	
It supports to post to multiple websites at once. There are examples in the file.


```xml

#MetaWeblog:
MetaWeblog:
   Cnblogs:
      MetaWeblog_username: <yourname>
	  MetaWeblog_url: http://www.cnblogs.com/<yourname>/services/metaweblog.aspx
	  MetaWeblog_blogid: 145005
   SINA:
	   MetaWeblog_username: huangbowen521@126.com
	   MetaWeblog_url: http://upload.move.blog.sina.com.cn/blog_rebuild/blog/xmlrpc.php
	   MetaWeblog_blogid: 200000
	 163blog:
	   MetaWeblog_username: huangbowen521@126.com
	   MetaWeblog_url: http://os.blog.163.com/api/xmlrpc/metaweblog/
	   MetaWeblog_blogid: 200001

```

4. add this task to Rakefile.

```ruby

desc "sync post to MetaWeblog site"
task :sync_post, :passwd do |t, args|
  puts "Sync the latest post to MetaWeblog site"
  system "ruby plugins/sync_post.rb  " + args[:passwd]
end

```

## Usage

1. run `rake generate` to generate sites.

2. run `rake sync_post["PASSWD"]` to sync the latest post to your website. `PASSWD` is your password for the blog sites(It is considered that all your blogs are under the same password). 

**Please note:** 

1. Some website require you enable MetaWeblog features in the dashboard. (ect. [cnblogs])

## How to keep same styling

Use [cnblogs] as a example.

1. use file uploader in cnblogs dashboard to upload screen.css file in your octopress project.

2. config the '页首html代码' in cnblogs dashboard to use the screen.css file.

(Maybe you should adjust the contents to resolve the styling conflict. You can see an example here: <http://files.cnblogs.com/huang0925/newScreen.css>)


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

* 博客园

	URL：http://www.cnblogs.com/<accountName>/services/metaweblog.aspx（example: http://www.cnblogs.com/bvbook/services/metaweblog.aspx）

* 网易

	URL: http://<accountName>.blog.163.com/ (example: http://huang0925.blog.163.com/).

[cnblogs]: http://www.cnblogs.com/