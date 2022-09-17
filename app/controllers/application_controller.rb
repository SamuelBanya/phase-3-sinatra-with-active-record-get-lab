class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"
  get "/bakeries" do 
    bakeries = Bakery.all()
    bakeries.to_json() 
  end

  get "/bakeries/:id" do
    # First attempt:
    # bakery_match = Bakery.find(:name = params[:id])
    # Second attempt:
    # bakery_match = Bakery.find(params[:id])
    bakery_match = Bakery.find(params[:id])
    # First attempt:
    # bakery_match.to_json(include: { baked_goods: })
    # Second attempt:
    # bakery_match.to_json(include: { :baked_goods })
    bakery_match.to_json(include: :baked_goods)
  end

  get "/baked_goods/by_price" do
    # First attempt:
    # baked_goods = BakedGood.all.sort(:price)
    # Second attempt:
    # baked_goods = BakedGood.all.order("price ASC")
    # Third attempt:
    # ordered_baked_goods = BakedGood.all.order("price DESC")
    # Fourth attempt with refactoring to make it Ruby specific and not SQL based:
    ordered_baked_goods = BakedGood.all.order(price: :desc)
    ordered_baked_goods.to_json()
  end

  get "/baked_goods/most_expensive" do 
    # First attempt
    # most_expensive_baked_good = BakedGood.all.order("price DESC").limit(1)
    # Second attempt:
    # most_expensive_baked_good = BakedGood.all.order("price ASC").limit(1)
    # Third attempt:
    most_expensive_baked_good = BakedGood.all.order(price: :desc).first()
    most_expensive_baked_good.to_json()
  end
end
