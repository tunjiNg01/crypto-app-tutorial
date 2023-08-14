//
//  MainViemModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import Combine

class MainViemModel: ObservableObject {
    @Published var allCoin: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    @Published var searchText = ""
    let dataService = CoindataServices()
    var cancellable = Set<AnyCancellable>()
    init() {
        addCoinSubscriber()
    }
    
    private func addCoinSubscriber() {
        dataService.$allCoins.sink { [weak self](returnedCoins) in
            self?.allCoin = returnedCoins
        }
        .store(in: &cancellable)

    }
}
