class ItemDecorator < SimpleDelegator
  def self.wrap(item)
    if item.name == 'Aged Brie'
      AgedBrie.new(item)
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass.new(item)
    elsif item.name == 'Conjured Mana Cake'
      ConjuredItem.new(item)
    elsif item.name == 'Sulfuras, Hand of Ragnaros'
      LegendaryItem.new(item)
    else
      new(item)
    end
  end

  def update
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
    adjustment = -1
    if sell_in < 0
      adjustment = -2
    end
    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrie < ItemDecorator
  def quality_adjustment
    adjustment = 1
    if sell_in < 0
      adjustment = 2
    end
    adjustment
  end
end

class BackstagePass < ItemDecorator
  def quality_adjustment
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
    adjustment
  end
end

class ConjuredItem < ItemDecorator
  def quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment = -4
    end
    adjustment
  end
end

class LegendaryItem < ItemDecorator
  def update
    # Legendary items don't change
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
