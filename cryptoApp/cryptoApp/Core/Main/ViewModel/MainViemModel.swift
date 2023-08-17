//
//  MainViemModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import Combine

class MainViemModel: ObservableObject {
    @Published  var statistics: [StatisticsModel] = []
    @Published var allCoin: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    @Published var searchText:String = ""
    @Published var isLoading: Bool = false
    @Published var sortOptions: SortOptions = .holdings
    
    private let coinDataService = CoindataServices()
    private let marketDataService = MarketDataServices()
    private let portfolioDataService = PortfolioDataService()
    
    var cancellable = Set<AnyCancellable>()
    
    enum SortOptions {
        case rank, rankReverse, holdings, holdingReverse, price, priceReverve
    }
    
    init() {
        addCoinSubscriber()
    }
    
    private func addCoinSubscriber() {
       
        $searchText.combineLatest(coinDataService.$allCoins, $sortOptions)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoin)
            .sink {[weak self] (filteredCoin) in
                self?.allCoin = filteredCoin
            }
            .store(in: &cancellable)
        
        // Portfolio subscriber
        $allCoin.combineLatest(portfolioDataService.$savedEntity)
            .map(portfolioHandler)
            .sink { [weak self] (returnedCoin) in
                guard let self = self else {return}
                self.portfolioCoin = self.sortByHoldingsIfNeeded(coin: returnedCoin) 
            }
            .store(in: &cancellable)
        
        // Update market Data
        marketDataService.$marketData
            .combineLatest($portfolioCoin)
            .map(mapGlobalMarketData)
            .sink {[weak self] (returnStatsData) in
                self?.statistics = returnStatsData
                self?.isLoading = false
            }
            .store(in: &cancellable)
       
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    private func filterAndSortCoin(text: String, coins: [CoinModel], sortOptions: SortOptions) -> [CoinModel]  {
       var filteredCoin = filterCoins(text: text, coins: coins)
       let sortedCoin = sortCoin(sort: sortOptions, coin: &filteredCoin)
       // sort
        
       return sortedCoin
    }
    private func sortCoin(sort: SortOptions, coin:inout [CoinModel]) -> [CoinModel] {
        switch sort{
        case .rank, .holdings:
            return coin.sorted(by: {$0.rank < $1.rank})
        case .rankReverse, .holdingReverse:
            return coin.sorted(by: {$0.rank > $1.rank})
        case .price:
            return coin.sorted(by: {$0.currentPrice > $1.currentPrice})
        case .priceReverve:
            return coin.sorted(by: {$0.currentPrice < $1.currentPrice})
       
        }
    }
    
    private func sortByHoldingsIfNeeded(coin: [CoinModel]) -> [CoinModel] {
        switch sortOptions {
        case .holdings:
            return coin.sorted(by: {$0.currentHoldingValue > $1.currentHoldingValue})
        case .holdingReverse:
            return coin.sorted(by: {$0.currentHoldingValue < $1.currentHoldingValue})
        default:
            return coin
        }
    }
    private func filterCoins(text: String, coins:  [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let textlowercase = text.lowercased()
        
        let filteredCoins = coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(textlowercase) || coin.id.lowercased().contains(textlowercase) ||
            coin.symbol.lowercased().contains(textlowercase)
        }
        return filteredCoins
    }
    
    private func portfolioHandler (coinModel: [CoinModel], porfolioEntity: [PortfolioEntity]) -> [CoinModel]{
        coinModel.compactMap { (coin) -> CoinModel? in
            guard let entity = porfolioEntity.first(where: {$0.coinID == coin.id})else {
                return nil
            }
            return coin.updateholdings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoin: [CoinModel]) -> [StatisticsModel]{
        var stats:[StatisticsModel] = []
        guard let data = marketDataModel else { return stats }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, parcentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24hrs Volume", value: data.volume)
        let bitcoinDominant = StatisticsModel(title: "BTC Dominant", value: data.bitcoinDominance)
        
        let portfolioValue = portfolioCoin
                             .map({$0.currentHoldingValue})
                             .reduce(0, +)
        let previousValue = portfolioCoin
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingValue
                let parcentageChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + parcentageChange)
                return previousValue
            }
            .reduce(0, +)
        let parcentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticsModel(title: "BTC Dominant",
                                        value: portfolioValue.setFormater(),
                                        parcentageChange: parcentageChange)
        stats.append(contentsOf: [
         marketCap,
         volume,
         bitcoinDominant,
         portfolio
        ])
        
        return stats
    }
}
