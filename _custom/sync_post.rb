require 'metaweblog'
require 'nokogiri'


module MetaWeblogSync


  class SyncPost

    def initialize
      @config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../_config.yml'))

      @blogClient = MetaWeblog::Client.new @config['MetaWeblog_url'], @config['MetaWeblog_blogid'].to_s, @config['MetaWeblog_username'], @config['MetaWeblog_password'].to_s, nil
    end

    def postBlog

      blogPath = getLatestBlogPath
      blogHtml = getBlogHtml blogPath
      post = getPost blogHtml


      puts 'posting new blog:' + post[:title]
      response = @blogClient.post(post)
      puts 'post fuccessfully. new blog id:' + response

    end

    def getLatestBlogPath
      indexFile = File.open(File.expand_path(File.dirname(__FILE__) + '/../public/index.html'), 'r')
      contents = indexFile.read
      html = Nokogiri::HTML(contents)

      # get latest post path
      path = html.css('//h1[@class="entry-title"]/a')[0]['href']

      File.expand_path(File.dirname(__FILE__) + '/../public' + path) + '/index.html'

    end

    def getBlogHtml(path)
      contents = File.open(path).read
      Nokogiri::HTML(contents)

    end

    def getPost html

      # get post title
      title = html.css('//h1[@class="entry-title"]')[0].content

      # get post content
      entryContent = html.css('//div[@class="entry-content"]')[0].to_html

      # keep same structure with a article
      article = '<div id="main"><div id="content"><div><article class="hentry" role="article">' + entryContent + '</article></div></div></div>'

      MetaWeblog::Post.new(title, '', article)
    end

  end

end

syncPost = MetaWeblogSync::SyncPost.new
syncPost.postBlog