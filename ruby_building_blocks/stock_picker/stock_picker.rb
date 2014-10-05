def make_recommendations(daily_prices)
  max_profit = 0
  purchase_day = 0
  sale_day = 0

  daily_prices.each_with_index do |price, day|
  	highest_remaining_price = daily_prices[day+1..-1].max

  	unless  highest_remaining_price.nil?
    	day_max_profit = highest_remaining_price - price

    	if day_max_profit > max_profit
        max_profit = day_max_profit
        purchase_day = day
        sale_day = daily_prices.index highest_remaining_price 
    	end
    end
  end

  recommendations = { :purchase_day => purchase_day, :sale_day => sale_day, :max_profit => max_profit }
end

daily_prices = [17,3,6,9,15,8,6,1,10]
stock_recommendations = make_recommendations(daily_prices)
puts "With daily prices of #{daily_prices}, it is best to buy on day #{stock_recommendations[:purchase_day] + 1} and sell on day #{stock_recommendations[:sale_day] + 1}, for a profit of #{stock_recommendations[:max_profit]}"
