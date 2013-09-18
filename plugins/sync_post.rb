require 'metaweblog'
require 'nokogiri'
require 'yaml'


module MetaWeblogSync

  class SyncPost

    def initialize passwd
     # @config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../metaweblog.yml'))
      @globalConfig = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../_config.yml'))
      @passwd = passwd
    end

    def postAllBlogs 
      #find all blogs paths
      postsPaths = getAllBlogsPaths
      #sync post from earlist to lastest
      postsPaths.reverse!
      postsPaths.each do | path|
        postBlog path
        sleep(61) #As time limit in blog wite, there should be a time gap in every loop
      end
    end

    def postLatestBlog 
      postPath = getLatestBlogPath
      puts postPath
      postBlog postPath 
    end

    def postBlogsAfter date
      #find all blogs paths
      postsPaths = getAllBlogsPaths
      postsPaths.each do | path|
        postDate = Date.parse(path[/\d{4}\/\d{2}\/\d{2}/])
        next if postDate <= date
        
        postBlog path
        sleep(120) #As time limit in blog wite, there should be a time gap in every loop
      end
    end

    def postBlogByTitle title
      postPath = getBlogPathByTitle title
      puts postPath
      postBlog postPath 
    end

    def postBlog blogPath
      blogHtml = getBlogHtml blogPath
      post = getPost blogHtml

      @globalConfig["MetaWeblog"].each do |site, paras|
        puts 'posting new blog:' + post[:title] + 'to ' + site
        blogClient = MetaWeblog::Client.new paras['MetaWeblog_url'], paras['MetaWeblog_blogid'].to_s, paras['MetaWeblog_username'], @passwd, nil
        response = blogClient.post(post)
        puts 'post successfully. new blog id: ' + response
      end
    end

    def getAllBlogsPaths
      html = getHtmlBy('/../public/blog/archives/index.html')

      # get latest post path
      paths = html.css('//h1/a')
      paths.shift
      
      paths.map {|path| 
        path = File.expand_path(File.dirname(__FILE__) + '/../public' + path['href']) + '/index.html'
      }
    end

    def getLatestBlogPath
      html = getHtmlBy('/../public/index.html')

      # get latest post path
      path = html.css('//h1[@class="entry-title"]/a')[0]['href']

      File.expand_path(File.dirname(__FILE__) + '/../public' + path) + '/index.html'
    end

    def getBlogPathByTitle title
      html = getHtmlBy('/../public/blog/archives/index.html')

      # get post path by title
      posts = html.css('//h1/a')

      path = String.new("")
      posts.each do | post|
        path = post['href'] if(post.text == title)
      end

      File.expand_path(File.dirname(__FILE__) + '/../public' + path) + '/index.html'
    end

    def getHtmlBy path
      indexFile = File.open(File.expand_path(File.dirname(__FILE__) + path), 'r')
      contents = indexFile.read
      html = Nokogiri::HTML(contents)
    end

    def getBlogHtml(path)
      contents = File.open(path).read
      Nokogiri::HTML(contents)

    end

    def getPost html

      # get post title
      title = html.css('//h1[@class="entry-title"]')[0].content

      entryContent = replaceImgUrl(html)

      # keep same structure with a article
      article = '<div id="main"><article class="hentry" role="article">' + entryContent + '</article></div>'

      MetaWeblog::Post.new(title, '', article)
    end

    def replaceImgUrl(html)
      content = html.css('//div[@class="entry-content"]')[0]

      imgList = content.css('img')

      imgList.each do |img|

        if (img['src'] != nil && !img['src'].match(/^http/))
          img['src'] = @globalConfig['url'] + img['src']
        end
      end

      # get post content
      content.to_html

    end

  end

end

