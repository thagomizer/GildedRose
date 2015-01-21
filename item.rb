class Item

  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def adjust_sellin
    return if name == "Sulfuras, Hand of Ragnaros"
    self.sell_in -= 1
  end

  def adjust_quality
    return if self.quality >= 50
    return if self.name == "Sulfuras, Hand of Ragnaros"

    case name
    when "Aged Brie"
      self.quality += aged_brie_adjustment
      return
    when "Backstage passes to a TAFKAL80ETC concert"
      self.quality += backstage_passes_adjustment
      return
    end


    if (self.quality > 0)
      self.quality += -1
    end

    return if self.quality <= 0
    return unless self.expired?

    self.quality += -1
  end

  def expired?
    self.sell_in < 0
  end

  def backstage_passes_adjustment
    return self.quality * -1 if self.expired?
    case
    when sell_in < 6
      3
    when sell_in < 11
      2
    else
      1
    end
  end

  def aged_brie_adjustment
    return 2 if self.expired?
    1
  end

  def degrade
    adjust_sellin
    adjust_quality
  end
end
