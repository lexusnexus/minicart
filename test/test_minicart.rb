require 'minitest/autorun'

require 'minicart/cart'

describe 'Cart' do
  before do
    @cart = Minicart::Cart.new
  end

  def non_empty_cart
    cart = Minicart::Cart.new
    cart.add_product 'product1'
    cart.add_product 'product3'
    cart.add_product 'product2'
    cart.add_product 'product3'
    cart
  end

  it 'create cart' do
    assert @cart
  end

  it 'add item to cart' do
    assert @cart.add_product('super product')
  end

  it 'count items' do
    assert_equal 0, @cart.count_items
    assert_equal 4, non_empty_cart.count_items
  end

  it 'get item by id' do
    cart = non_empty_cart
    item = cart.items[1]
    assert_equal 'product3', cart.item(item.id).product
  end

  it 'clear cart content' do
    assert_equal [], @cart.items
    @cart.add_product 'some product'
    assert_equal 1, @cart.count_items
    refute_equal [], @cart.items
    @cart.clear
    assert_equal [], @cart.items
  end

  it 'remove product from cart' do
    cart = non_empty_cart
    item_id = cart.items[2].id
    assert cart.item(item_id)
    cart.remove(item_id)
    refute cart.item(item_id)
  end

  it 'increment quantity for adding same product' do
    item_id = @cart.add_product 'popular product'
    @cart.add_product 'popular product'
    assert_equal 2, @cart.item(item_id).quantity
  end

  it 'add item to cart return item_id' do
    assert_equal @cart.add_product('some product'), @cart.items[0].id
  end

  it 'set quantity of item in shopping cart' do
    cart = non_empty_cart
    item = cart.items[0]
    assert_equal 1, item.quantity
    cart.update_quantity(item.id, 99)
    assert_equal 99, item.quantity
  end

  it 'possible usage scenario' do
    class Product
      attr_accessor :sku, :name, :price

      def initialize(sku, name, price)
        @sku, @name, @price = sku, name, price
      end
    end

    ipad2 = Product.new('ipad2', 'Apple Ipad 2', 500)
    ipod3 = Product.new('ipod3', 'Apple Ipod 3rd Gen', 400)
    iphone4 = Product.new('iph4', 'Apple Iphone 4', 800)

    cart = Minicart::Cart.new
    ipod3_id = cart.add_product ipod3
    iphone4_id = cart.add_product iphone4
    ipad2_id = cart.add_product ipad2
    cart.add_product ipod3


    cart.remove ipad2_id

    cart.update_quantity(iphone4_id, 5)

    # check result
    assert_equal 7, cart.count_items
    assert_equal %w[ipod3 iph4], cart.items.map{ |item| item.product.sku }
    assert_equal 5, cart.item(iphone4_id).quantity
    assert_equal 400, cart.item(ipod3_id).product.price
 
    # You can store any object in cart as product
    # for example: hashes or strings
    cart = Minicart::Cart.new

    id1 = cart.add_product({'name'=>'Windows', 'price'=>100})
    assert_equal 100, cart.item(id1).product['price']

    id2 = cart.add_product 'Love Linux'
    assert_equal 'Love Linux', cart.item(id2).product
  end
end

