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
    @Published var searchText = ""
    private let coinDataService = CoindataServices()
    private let marketDataService = MarketDataServices()
    var cancellable = Set<AnyCancellable>()
    init() {
        addCoinSubscriber()
    }
    
    private func addCoinSubscriber() {
       
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] (filteredCoin) in
                self?.allCoin = filteredCoin
            }
            .store(in: &cancellable)
        // Update market Data
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink {[weak self] (returnStatsData) in
                self?.statistics = returnStatsData
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
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
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticsModel]{
        var stats:[StatisticsModel] = []
        guard let data = marketDataModel else { return stats }
        let marketCap = StatisticsModel(title: "Market Cap", value: data.marketCap, parcentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticsModel(title: "24hrs Volume", value: data.volume)
        let bitcoinDominant = StatisticsModel(title: "BTC Dominant", value: data.bitcoinDominance)
        let portfolio = StatisticsModel(title: "BTC Dominant", value: "$0.00", parcentageChange: 0)
        stats.append(contentsOf: [
         marketCap,
         volume,
         bitcoinDominant,
         portfolio
        ])
        
        return stats
    }
}
