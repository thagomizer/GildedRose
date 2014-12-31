require './gilded_rose.rb'
require "minitest/autorun"

## From the readme
#
#   - Once the sell by date has passed, Quality degrades twice as fast
#   - The Quality of an item is never negative
#   - "Aged Brie" actually increases in Quality the older it gets
#   - The Quality of an item is never more than 50
#   - "Sulfuras", being a legendary item, never has to be sold or decreases in
#     Quality
#   - "Backstage passes", like aged brie, increases in Quality as it's SellIn
#     value approaches; Quality increases by 2 when there are 10 days or less
#     and by 3 when there are 5 days or less but Quality drops to 0 after the
#     concert

class TestGildedRose < Minitest::Test
  def setup
    @gr = GildedRose.new
    @gr.items = []
  end

  def test_update_quality_degrades_items
    item = Item.new("item", 10, 100)
    @gr.items << item

    @gr.update_quality

    assert_equal 99, item.quality
  end

  def test_update_quality_decreases_sell_in
    item = Item.new("item", 10, 100)
    @gr.items << item

    @gr.update_quality

    assert_equal 9, item.sell_in
  end

  def test_item_degrades_2x_after_sell_by_date
    base_quality = 100
    sell_soon = Item.new("sell soon", 0, base_quality)
    @gr.items << sell_soon

    @gr.update_quality
    assert_equal base_quality - 2, sell_soon.quality

    @gr.update_quality
    assert_equal base_quality - 4, sell_soon.quality
  end

  def test_quality_of_item_never_negative
    base_quality = 0
    item = Item.new("crap", 10, base_quality)
    @gr.items << item

    @gr.update_quality
    assert_equal base_quality, item.quality
  end

  def test_aged_brie_increases_through_time
    brie = Item.new("Aged Brie", 2, 0)
    @gr.items << brie

    @gr.update_quality
    assert_equal 1, brie.quality
  end

  def test_quality_is_never_more_than_50
    skip
  end

  def test_sulfuras_sell_in_never_decreases
    skip
  end

  def test_sulfuras_quality_never_decreases
    skip
  end

  # TODO backstage passes
end

## First an introduction to our system:
#
# - All items have a SellIn value which denotes the number of days we have to
#   sell the item
# - All items have a Quality value which denotes how valuable the item is
# - At the end of each day our system lowers both values for every item

class TestItem < Minitest::Test

  def test_items_have_name_sellin_and_quality
    name = "NAME"
    sell_in = 10
    quality = 7

    item = Item.new(name, sell_in, quality)

    assert_equal name,    item.name
    assert_equal sell_in, item.sell_in
    assert_equal quality, item.quality
  end

  def test_item_properties_should_be_mutable
    item = Item.new("item", 11, 13)

    item.name    = "new name"
    item.sell_in = 1
    item.quality = 100

    assert_equal "new name", item.name
    assert_equal 1,          item.sell_in
    assert_equal 100,        item.quality
  end
end
