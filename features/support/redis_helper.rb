require 'redis'

module Redis_Helper


  def remove_all_redis_key
    keys = @redis.keys
    @redis.del(*keys) unless keys.empty?
  end

  def remove_redis_key(key)
    #example for use remove_redis_key("mykey")
    @redis.del(key)
  end

  def create_redis_key(key, value)
    #example for use create_redis_key('foo','view')
    @redis.set("mykey", "hello world")
  end


  def get_redis_key(key)
    #example for use get_redis_key("mykey")
    @redis.get(key)
  end

end
World(Redis_Helper)
