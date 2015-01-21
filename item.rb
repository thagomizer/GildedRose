class Item

  attr_accessor :name, :sell_in, :quality

  def initialize (name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def degrade
    if (self.name != "Aged Brie" && self.name != "Backstage passes to a TAFKAL80ETC concert")
      if (self.quality > 0)
        if (self.name != "Sulfuras, Hand of Ragnaros")
          self.quality = self.quality - 1
        end
      end
    else
      if (self.quality < 50)
        self.quality = self.quality + 1
        if (self.name == "Backstage passes to a TAFKAL80ETC concert")
          if (self.sell_in < 11)
            if (self.quality < 50)
              self.quality = self.quality + 1
            end
          end
          if (self.sell_in < 6)
            if (self.quality < 50)
              self.quality = self.quality + 1
            end
          end
        end
      end
    end
    if (self.name != "Sulfuras, Hand of Ragnaros")
      self.sell_in = self.sell_in - 1;
    end
    if (self.sell_in < 0)
      if (self.name != "Aged Brie")
        if (self.name != "Backstage passes to a TAFKAL80ETC concert")
          if (self.quality > 0)
            if (self.name != "Sulfuras, Hand of Ragnaros")
              self.quality = self.quality - 1
            end
          end
        else
          self.quality = self.quality - self.quality
        end
      else
        if (self.quality < 50)
          self.quality = self.quality + 1
        end
      end
    end
  end

end
