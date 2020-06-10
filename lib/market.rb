class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors =[]
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    market_inventory = Hash.new
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        if market_inventory[item].nil?
          market_inventory[item] = Hash.new(0)
          market_inventory[item][:quantity] += amount
          market_inventory[item][:vendors] = vendors_that_sell(item)
        else
          market_inventory[item][:quantity] += amount
        end
      end
    end
    market_inventory
  end

  def overstocked_items
    overstocked = []
    total_inventory.each do |item, info|
      overstocked  << item if info.values[0] > 50 && info.values[1].size > 1
    end
    overstocked
  end
end
