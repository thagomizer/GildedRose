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
      update_aged_brie
      return
    end


    case name
    when "Backstage passes to a TAFKAL80ETC concert"
      self.quality += 1
      if (self.sell_in < 11)
        self.quality += 1
      end
      if (self.sell_in < 6)
        self.quality += 1
      end
    else
      if (self.quality > 0)
        self.quality += -1
      end
    end

    return if self.quality <= 0
    return unless self.expired?

    case name
    when "Backstage passes to a TAFKAL80ETC concert"
      self.quality += -1 * self.quality
    else
      self.quality += -1
    end
  end

  def expired?
    self.sell_in < 0
  end

  def update_aged_brie
    self.quality += 1
    self.quality += 1 if self.expired?
  end




  def degrade
    adjust_sellin
    adjust_quality
  end
end
