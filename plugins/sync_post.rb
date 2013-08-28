require 'metaweblog'
require 'nokogiri'
require 'yaml'


module MetaWeblogSync

  class SyncPost

    def initialize
     # @config = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../metaweblog.yml'))
      @globalConfig = YAML.load_file(File.expand_path(File.dirname(__FILE__) + '/../_config.yml'))
    end

    def postBlogs passwd

      blogPath = getLatestBlogPath
      blogHtml = getBlogHtml blogPath
      post = getPost blogHtml

      @globalConfig["MetaWeblog"].each do |site, paras|
        puts 'posting new blog:' + post[:title] + 'to ' + site
        puts "input passwd :" + passwd

        blogClient = MetaWeblog::Client.new paras['MetaWeblog_url'], paras['MetaWeblog_blogid'].to_s, paras['MetaWeblog_username'], passwd, nil
        response = blogClient.post(post)
        puts 'post successfully. new blog id: ' + response
      end
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

      entryContent = replaceImgUrl(html)


      # keep same structure with a article
      article = '<div id="main"><article class="hentry" role="article">' + entryContent + '</article></div>'


      MetaWeblog::Post.new(title, '', article)
    end

    def replaceImgUrl(html)
      content = html.css('//div[@class="entry-content"]')[0]

      imgList = content.css('img')

      imgList.each do |img|

        if (!img['src'].match(/^http/))
          img['src'] = @globalConfig['url'] + img['src']
        end
      end

      # get post content
      content.to_html

    end

  end

end

syncPost = MetaWeblogSync::SyncPost.new
syncPost.postBlogs $*[0]