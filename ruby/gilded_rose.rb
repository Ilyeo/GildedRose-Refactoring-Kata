class ItemDecorator < SimpleDelegator
  def self.wrap(item)
    case item.name
    when 'Aged Brie'
      AgedBrie.new(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass.new(item)
    when 'Conjured Mana Cake'
      ConjuredItem.new(item)
    when 'Sulfuras, Hand of Ragnaros'
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
    if sell_in < 0
      past_date_adjustment
    else
      normal_adjustment
    end
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end

  def normal_adjustment
    -1
  end

  def past_date_adjustment
    2 * normal_adjustment
  end
end

class AgedBrie < ItemDecorator
  def normal_adjustment
    -super
  end
end

class BackstagePass < ItemDecorator
  def normal_adjustment
    if sell_in < 5
      3
    elsif sell_in < 10
      2
    else
      1
    end
  end

  def past_date_adjustment
    -quality
  end
end

class ConjuredItem < ItemDecorator
  def normal_adjustment
    2 * super
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
