class ProductsController < ApplicationController
  # before_action :require_user
  # before_action :set_product, only: %i[ show edit update destroy ]
  # GET companies/id?/products or /companies/id?/products.json
 def search
  query = params[:search_products].presence && params[:search_products][:query]

if query
  @products = Product.search_published(query)
end
 end
 
  def index

  #  @brand = Brand.where(company_id: Redis.current.get("company_id"))
  #  @products = Product.all
  client = Ignite::Client.new(username: " username ", password: " password ",host:" hosted url ",port:"10800")
  cache = client.get_or_create_cache("test")
  $i = client.query("SELECT COUNT(ID) FROM PRODUCTS")
  client.query("INSERT INTO PUBLIC.PRODUCTS(ID, NAME, PRICE, SUBCATEGORY_ID, BRAND_ID, QUANTITY, DESCRIPTION)VALUES(#{$i[0]["COUNT(ID)"]+1}, '#{Faker::Commerce.product_name}', #{Faker::Number.between(1, 100)}, #{Faker::Number.between(8, 50)}, #{Faker::Number.between(6, 10)}, 100, '#{Faker::Commerce.department(2, true)}')")
  # @prod = Product.new( name:"FAKE", price: 99,brand_id: 51,subcategory_id: 11, availability: 100,description: "FAKE DEP")
  # @prod.save
  # @products = Product.all

  @products = client.query("SELECT * FROM PRODUCTS")
   respond_to do |format|
       format.html  # index.html.erb
       format.json  { render :json => @products }
   end
  end
  # GET /companies/id?/products/1 or /companies/id?/products/1.json
  def show
    storage = Google::Cloud::Storage.new(
       project_id: " ID",
       credentials: "../keyfile.json"
     )
    
    bucket = storage.bucket " BUCKET NAME "
      @product = Product.find(params[:id])
      if (file = bucket.file "#{@product.id}.jpg")
        @url = " firebase url "
      else
        @url = " firebase url "
      end
  end
  def new
      @product = Product.new
      puts "#{@product}"
      respond_to do |format|
        format.html  # new.html.erb
        format.json  { render :json => @product }
      end
  end
  # POST /products/new
  def create
      @product = Product.new(product_params)
      # @product[:brand_id] = 99
      @product.brand_id =  Redis.current.get("brand_id")
      $val = @product.availability
      # @product.availability = $val.to_b
      respond_to do |format|
          if @product.save
            file_data = product_params_image[:image].tempfile.path
    storage = Google::Cloud::Storage.new(
       project_id: " ID ",
       credentials: "../keyfile.json"
     )
    
    bucket = storage.bucket " BUCKET NAME "
    file = bucket.create_file file_data , "#{@product.id}.jpg"
              format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
              format.json { render :show, status: :created, location: @product }
          else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @product.errors, status: :unprocessable_entity }
          end

         
      end
    end

    # GET /companies/id?/products/1/edit
def edit
  @product = Product.find(params[:id])
end
# PATCH/PUT /companies/id?/products/1 or /companies/id?/products/1.json
def update
  if(Redis.current.get("shopper_id") == nil)
    puts"-==========COMPANY IS LOGGED IN =============-"
    respond_to do |format|
      if @product.update(product_params)
        file_data = product_params_image[:image].tempfile.path
        storage = Google::Cloud::Storage.new(
          project_id: " ID",
          credentials: "../keyfile.json"
        )
        bucket = storage.bucket " BUCKER NAME "
        file = bucket.create_file file_data , "#{@product.id}.jpg"
        format.html { redirect_to product_url(@product), notice: "Product was updated successfully." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
      return 
    end
  else
  puts"-~~~~~~~~~~~~~~~~~~~~~ USER IS LOGGED IN #{Redis.current.get("shopper_id")} -~~~~~~~~~~~~~~~~~~~~~"
    prod_qty=product_params[:quantity]
    # @cart = Cart.where(shopper_id: Redis.current.get("shopper_id")).first
    client = Ignite::Client.new
    count = client.query("SELECT COUNT(ID) FROM CARTS")
    $ID = count[0]["COUNT(ID)"] + 1
    # @product = Product.find(params[:id])  
    @product = client.query("SELECT * FROM PRODUCTS WHERE ID = #{params[:id]}")
    $cart_total = @product[0]["PRICE"] * prod_qty.to_i
    Redis.current.set("cart_#{$ID}_total","#{$cart_total}")
    Redis.current.set("cart_id","#{$ID}")
    client.query("INSERT INTO PUBLIC.CARTS(ID, TOTAL, SHOPPER_ID, QTY, ORDER_ID, PRODUCT_NAME, PRODUCT_PRICE)VALUES(#{$ID}, #{$cart_total}, #{Redis.current.get("shopper_id")},#{prod_qty.to_i},0, '#{@product[0]["NAME"]}', #{@product[0]["PRICE"].to_i})")
    # @cart = client.query("SELECT * FROM CARTS WHERE SHOPPER_ID = #{Redis.current.get("shopper_id")}")
    # if (@cart == [])
      # puts "Cart not found creating New cart"  
      # @cart.qty += prod_qty.to_i  
      # @cart.shopper_id= Redis.current.get("shopper_id")
      # prod = {
      #     "product_id" : "#{@product.id}",
      #     "product_name" : "#{@product.name}",
      #     "product_qty" : "#{prod_qty.to_i}",  
      #     "product_total" : "#{@product.price * prod_qty.to_i}",  
      #     "retailer_id" => "#{Redis.current.get("retailer_id")}",  
      #     "status" => "false"  
      # }
      # @cart.products = prod
      # @cart.save  
      # puts "-=========PRODUCT IN CART AS: #{prod}==========-"
      # respond_to do |format|  
      #   if @cart.save  
      #     format.html { redirect_to cart_url(@cart), notice: "Added to cart" }
      #     format.json { render :show, status: :created, location: @cart }  
      #   else
      #     format.html { render :new, status: :unprocessable_entity }
      #     format.json { render json: @cart.errors, status: :unprocessable_entity }
      #   end
      # end 
    # else  
    #   puts "Cart already exists"  
    #   cart_qty = @cart[0]["QTY"] + prod_qty.to_i  
    #   @product = Product.find(params[:id])  
    #   @prod_total = @product.price * prod_qty.to_i  
    #   $cart_total = @cart[0]["TOTAL"] + @prod_total  
    #   Redis.current.set("cart_#{@cart[0]["ID"]}_total","#{@cart[0]["TOTAL"]}")  
    #   @a = @cart[0]["ITEMS"]
    #   @b = {  
    #       "product_id" => "#{@product.id}",  
    #       "product_name" => "#{@product.name}",  
    #       "product_qty" => "#{prod_qty.to_i}",  
    #       "product_total" => "#{@product.price * prod_qty.to_i}",  
    #       "retailer_id" => "#{Redis.current.get("retailer_id")}",  
    #       "status" => "false"  
    #   }.to_json
    #   @c = "#{@a}, #{@b}"
    #   client = Ignite::Client.new
    #   client.query("UPDATE PUBLIC.CARTS SET TOTAL=#{$cart_total}, QTY=#{cart_qty}, ITEMS='#{@c}';")
    #   # @cart.products = prod    
    #   # @cart.save
    #   puts "-=========PRODUCT IN CART AS: #{@cart[0]["ITEMS"]}==========-"
    #   # respond_to do |format|  
    #   #   if @cart.save  
    #   #     format.html { redirect_to cart_url(@cart), notice: "Added to cart" }
    #   #     format.json { render :show, status: :created, location: @cart }  
    #   #   else
    #   #     format.html { render :new, status: :unprocessable_entity }
    #   #     format.json { render json: @cart.errors, status: :unprocessable_entity }
    #   #   end
    #   # end   
    # end
  end
end



# DELETE /companies/id?/products/1 or /companies/id?/products/1.json
def destroy
  @product.destroy
  respond_to do |format|
    format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    format.json { head :no_content }
  end
end
private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    # @product = Product.find(params[:id])
    client = Ignite::Client.new
    @product = client.query("SELECT * FROM PRODUCTS WHERE ID = #{params[:id]}")
    # @brand = Brand.find(@product.brand_id)
    @brand = client.query("SELECT * FROM BRANDS WHERE ID = #{@product[0]["BRAND_ID"]}")
    # @company = Company.find(@brand.company_id)
    @company = client.query("SELECT * FROM COMPANIES WHERE ID = #{@brand[0]["COMPANY_ID"]}")
    Redis.current.set("product_id","#{@product[0]["ID"]}")
    puts"========= REDIS SAVED PRODUCT ID #{Redis.current.get("product_id")} ========="
    Redis.current.set("company_id","#{@company[0]["ID"]}")
    puts"========= REDIS SAVED COMPANY ID #{Redis.current.get("company_id")} ========="
  end
  # Only allow a list of trusted parameters through.
  def product_params_image
    params.require(:product).permit(:name, :description, :price, :brand_id, :availability, :quantity, :subcategory , :image)
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :brand_id, :availability, :quantity, :subcategory)
  end
end