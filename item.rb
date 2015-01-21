class Item

  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def adjust_sellin
    case name
    when "Sulfuras, Hand of Ragnaros"
      nil
    else
      self.sell_in -= 1
    end
  end

  def adjust_quality
    return if self.quality >= 50
    return if self.name == "Sulfuras, Hand of Ragnaros"

    if (self.name != "Aged Brie" && self.name != "Backstage passes to a TAFKAL80ETC concert")
      if (self.quality > 0)
        self.quality = self.quality - 1
      end
    else
      self.quality = self.quality + 1
      if (self.name == "Backstage passes to a TAFKAL80ETC concert")
        if (self.sell_in < 11)
          self.quality = self.quality + 1
        end
        if (self.sell_in < 6)
          self.quality = self.quality + 1
        end
      end
    end

    if (self.sell_in < 0)
      if (self.name != "Aged Brie")
        if (self.name != "Backstage passes to a TAFKAL80ETC concert")
          if (self.quality > 0)
            self.quality = self.quality - 1
          end
        else
          self.quality = 0
        end
      else
        self.quality = self.quality + 1
      end
    end
  end

  def degrade
    adjust_sellin
    adjust_quality
  end
end
