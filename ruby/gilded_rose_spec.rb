require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "item sell in has passed" do
    it "quality degrees twice as fast" do
      items = [Item.new("item name", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe "item quality never is negative" do
    it "quality still being zero" do
      items = [Item.new("item name", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe "Aged Brie item" do
    it "item name is \"Aged Brie\"" do
      items = [Item.new("Aged Brie", 0, 0)]
      expect(items[0].name).to eq "Aged Brie"
    end

    it "increases in quality the older it gets" do
      items = [Item.new("Aged Brie", 1, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end

    it "quality still being 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end
  end

end
