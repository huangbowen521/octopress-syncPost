octopress-syncPost
==================

A octopress plugin to sync post(all posts or latest post) to a website which suport MetaWeblog. (CNBlogs,BlogBus, Wordpress etc.)


## Configure

1. Checkout this repository, **copy files in plugins into octopress/plugins/ folder.**

2. add new gem denpendencies to Gemfile.

	```ruby
	  gem 'metaweblog', '~> 0.1.0'
	  gem 'nokogiri', '~> 1.5.9'
	```
	(The first gem is used to send post with MetaWeblog API.
	The second gem is used to parse html.)

	then run `bundle install` to install them.

3. add this task to Rakefile.

```ruby
desc "sync latest post to MetaWeblog site"
task :sync_latest_post, :passwd do |t, args|
  puts "Sync the latest post to MetaWeblog site"
  if :passwd.nil?
	system "ruby plugins/sync_latest_post.rb  " + args[:passwd]
  else
	system "ruby plugins/sync_latest_post.rb"
  end
end

desc "sync all posts to MetaWeblog site(s)"
task :sync_all_posts, :passwd do |t, args|
  puts "Sync all posts to MetaWeblog site(s)"
  if :passwd.nil?
	system "ruby plugins/sync_all_posts.rb  " + args[:passwd]
  else
	system "ruby plugins/sync_all_posts.rb"
  end
end

desc "sync posts after date to MetaWeblog site(s)"
task :sync_posts_after_date, :date, :passwd do |t, args|
  puts "Sync posts after date to MetaWeblog site(s)"
  if :passwd.nil?
	system "ruby plugins/sync_posts_after_date.rb  \"" + args[:date] + "\" " + args[:passwd]
  else
	system "ruby plugins/sync_posts_after_date.rb  \"" + args[:date] + "\""
  end
end

desc "sync post by title to MetaWeblog site(s)"
task :sync_post_by_title, :title, :passwd do |t, args|
  puts "Sync post by title to MetaWeblog site(s)"
  if :passwd.nil?
	system "ruby plugins/sync_post_by_title.rb  \"" + args[:title] + "\" " + args[:passwd]
  else
	system "ruby plugins/sync_post_by_title.rb  \"" + args[:title] +"\""
  end
end

```


4. Add blogs configuration to the end of octopress/_config.yml


``` xml

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


## Usage

1. run `rake generate` to generate sites to make all posts brand new.


2. run `rake sync_latest_post["PASSWD"]` to sync the latest post to your website. 
or run `rake sync_all_posts["PASSWD"]` to sync all posts to your website. `PASSWD` is your password for the blog sites(It is considered that all your blogs are under the same password). If the `PASSWD` is omitted, the program will ask you for the password of each blog site. In sync-all way, as time limit from blog site, time gap between each post sending is set to 61 seconds. That may cost some time if you've got large sum of posts, It's your coffee time ;)


3. run `rake sync_posts_after_date["date","PASSWD"]` to sync the posts after compare date to your website, `date` is the date string, some thing like "2013-01-01" or "2013/01/01" or "Jan 1 2013". 


4. run `rake sync_post_by_title["title","PASSWD"]` to sync a post by the post title to your website. 


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

## Next steps

New features I'd like to add to this plugin:

* eliminate duplication when csync_all_posts.
* Till now, I've just tested cnblog. All other metaWeblog supported website should be tested.
* Code block is not compatible in cnblogs?

Welcome to make suggestions ot contribute to this repo :)
