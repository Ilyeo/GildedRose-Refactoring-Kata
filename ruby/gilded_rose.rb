class ItemDecorator < SimpleDelegator
  def update
    if (name != 'Aged Brie') && (name != 'Backstage passes to a TAFKAL80ETC concert')
      if quality > 0
        if name != 'Sulfuras, Hand of Ragnaros'
          self.quality = self.quality - 1
        end
      end
    else
      if quality < 50
        self.quality = self.quality + 1
        if name == 'Backstage passes to a TAFKAL80ETC concert'
          if sell_in < 11
            self.quality = self.quality + 1 if quality < 50
          end
          if sell_in < 6
            self.quality = self.quality + 1 if quality < 50
          end
        end
      end
    end
    self.sell_in = self.sell_in - 1 if name != 'Sulfuras, Hand of Ragnaros'
    if sell_in < 0
      if name != 'Aged Brie'
        if name != 'Backstage passes to a TAFKAL80ETC concert'
          if quality > 0
            if name != 'Sulfuras, Hand of Ragnaros'
              self.quality = self.quality - 1
            end
          end
        else
          self.quality = self.quality - self.quality
        end
      else
        self.quality = self.quality + 1 if quality < 50
      end
    end
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update(ItemDecorator.new(item))
    end
  end

  def update(item)
    item.update
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
