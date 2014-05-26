require './plugins/sync_post.rb'
raise "post date should not be empty" if($*[0] == nil)
begin
	date = Date.parse($*[0])
rescue Exception=>e
	raise "please give a correct date string, like: 2013-01-01"
end	
if $*[1] != nil
  syncPost = MetaWeblogSync::SyncPost.new $*[1]
else
  syncPost = MetaWeblogSync::SyncPost.new
end
syncPost.postBlogsAfter date
