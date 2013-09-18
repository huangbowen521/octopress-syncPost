require './plugins/sync_post.rb'
if $*[0] != nil #It seems to be runed when rake generate. I don't quite understand.
  syncPost = MetaWeblogSync::SyncPost.new $*[0]
  raise "post title should not be empty" if($*[1] == nil)
  syncPost.postBlogByTitle $*[1]
end