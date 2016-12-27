require 'vkontakte_api'
require 'pp'

TOKEN = ""
OWNER_ID = -2039502

ITERATE_OVER_ALBUM = false

VkontakteApi.configure do |config|
  config.log_requests = false
end

@vk = VkontakteApi::Client.new(TOKEN)
@vk.photos.getAlbums(owner_id:  OWNER_ID).each { |a|
   new_a =  {photos: []}
   `touch #{a["aid"]}`
   puts a["aid"]
   `mkdir _#{a["aid"]} && wget -i #{a["aid"]} -P ./_#{a["aid"]}`
   if ITERATE_OVER_ALBUM
     @vk.photos.get(owner_id: OWNER_ID, album_id: a["aid"]).each { |p|
       url = p["src_xxxbig"] || p["src_xxbig"] || p["src_xbig"] || p["src_big"] || p["src"] 
       puts url
       `echo #{url} >> #{a["aid"]}`
       sleep 0.1
     }
   end
   puts ""
}


