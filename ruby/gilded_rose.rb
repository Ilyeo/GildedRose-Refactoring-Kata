class ItemDecorator < SimpleDelegator
  def self.wrap(item)
    new(item)
  end

  def update
    return if name == 'Sulfuras, Hand of Ragnaros'
    update_sell_in
    update_quality
  end

  def update_sell_in
    self.sell_in -= 1
  end

  def update_quality
    self.quality += quality_adjustment
  end

  def quality_adjustment
    if name == 'Aged Brie'
      adjustment = 1
      if sell_in < 0
        adjustment = 2
      end
    elsif name == 'Backstage passes to a TAFKAL80ETC concert'
      adjustment = 1
      if sell_in < 10
        adjustment = 2
      end
      if sell_in < 5
        adjustment = 3
      end
      if sell_in < 0
        adjustment = -quality
      end
    elsif name == 'Conjured Mana Cake'
      adjustment = -2
      if sell_in < 0
        adjustment = -4
      end
    else
      adjustment = -1
      if sell_in < 0
        adjustment = -2
      end
    end
    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      ItemDecorator.wrap(item).update
    end
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
