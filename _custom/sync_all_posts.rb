require './_custom/sync_post.rb'
if $*[0] != nil
  syncPost = MetaWeblogSync::SyncPost.new $*[0]
else
  syncPost = MetaWeblogSync::SyncPost.new
end
syncPost.postAllBlogs
