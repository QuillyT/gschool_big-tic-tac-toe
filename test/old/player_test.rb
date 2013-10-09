gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/model/player.rb'

class PlayerTest < Minitest::Test
   def test_it_exists
     p = Player.new
     assert_kind_of Player, p
   end

   def test_it_is_different?
     p1 = Player.new
     p2 = Player.new
     refute_equal p1.object_id, p2.object_id
   end
end
