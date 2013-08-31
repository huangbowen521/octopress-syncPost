require './plugins/sync_post.rb'
if $*[0] != nil #It seems to be runed when rake generate. I don't quite understand.
  syncPost = MetaWeblogSync::SyncPost.new $*[0]
  syncPost.postAllBlogs
end