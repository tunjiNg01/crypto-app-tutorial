//
//  MainViemModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import Combine

class MainViemModel: ObservableObject {
    @Published  var stats: [StatisticsModel] = [
        StatisticsModel(title: "Market Cap", value: "$23.45", parcentageChange: 21.46),
        StatisticsModel(title: "Market Cap", value: "$23.45"),
        StatisticsModel(title: "Market Cap", value: "$23.45"),
        StatisticsModel(title: "Market Cap", value: "$23.45", parcentageChange: -1.46)
        
    ]
    @Published var allCoin: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    @Published var searchText = ""
    let dataService = CoindataServices()
    var cancellable = Set<AnyCancellable>()
    init() {
        addCoinSubscriber()
    }
    
    private func addCoinSubscriber() {
       
        $searchText.combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] (filteredCoin) in
                self?.allCoin = filteredCoin
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
}
