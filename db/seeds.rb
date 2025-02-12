User.destroy_all
Portfolio.destroy_all
Asset.destroy_all
Transaction.destroy_all

joseph = User.create(name: "Joseph Lee", email: "jhjlee702@gmail.com", password: "123456", password_confirmation: "123456")

retirement_portfolio = Portfolio.create(user_id: joseph.id, name: "retirement")

vanguard_index_fund = Asset.create(portfolio_id: retirement_portfolio.id, symbol: "VTSAX", name: "Vanguard Total Stock Market Index Fund Admiral Shares", quantity: 100, market_price: 500.0)

vg_purchase = Transaction.create(asset_id: vanguard_index_fund.id, trade_type: "Purchase", amount: 100, price: 145.39, executed_at: "2024-02-03 14:00:00 UTC")

Asset.create(portfolio_id: retirement_portfolio.id, symbol: "BTC", name: "Bitcoin", quantity: 100, market_price: nil)