require './plugins/sync_post.rb'
if $*[0] != nil #It seems to be runed when rake generate. I don't quite understand.
  syncPost = MetaWeblogSync::SyncPost.new $*[0]
  begin
  	date = Date.parse($*[1])
  rescue Exception=>e
  	raise "please give a correct date string, like: 2013-01-01"
  end	
  syncPost.postBlogsAfter date
end