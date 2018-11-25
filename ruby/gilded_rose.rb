class ItemDecorator < SimpleDelegator
  def update
    return if name == 'Sulfuras, Hand of Ragnaros'
    update_sell_in
    update_quality
  end

  def update_sell_in
    self.sell_in -= 1
  end

  def update_quality
    if name == 'Aged Brie' || name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality
      if name == 'Backstage passes to a TAFKAL80ETC concert'
        if sell_in < 11
          increase_quality
        end
        if sell_in < 6
          increase_quality
        end
      end
    else
      decrease_quality
    end
    if sell_in < 0
      if name == 'Aged Brie'
        increase_quality
      elsif name == 'Backstage passes to a TAFKAL80ETC concert'
        self.quality -= quality
      else
        decrease_quality
      end
    end
  end

  def increase_quality
    if quality < 50
      self.quality += 1
    end
  end

  def decrease_quality
    if quality > 0
      self.quality -= 1
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
