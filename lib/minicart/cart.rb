module Minicart
  class Cart
    # - cart is a collection of items
    # - item is a product, quantity and id of item

    class Item
      attr_accessor :id, :product, :quantity

      def initialize(product, quantity = 1, id = self.object_id)
        @product, @quantity, @id = product, quantity, id
      end
    end

    def initialize
      @items = []
    end

    def items
      @items
    end

    def add_product(product)
      if item = item_from_product(product)
        update_quantity(item.id, item.quantity + 1)
      else
        @items << item = Item.new(product)
      end
      item.id
    end

    def item(item_id)
      @items.detect { |item| item.id == item_id }
    end

    def remove(item_id)
      @items.delete_if { |item| item.id == item_id }
    end

    def update_quantity(item_id, quantity)
      @items.map { |item| item.quantity = quantity if item.id == item_id }
    end

    def count_items
      items.inject(0) { |sum, item| sum += item.quantity }
    end

    def clear
      @items.clear
    end

    def item_from_product(product)
      @items.detect { |item| item.product == product }
    end

  end
end
