//
//  CoinDetailsViewModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 18/08/2023.
//

import Foundation
import Combine


class CoinDetailsViewModel: ObservableObject {
    private let coinDetailService: CoinDetailsDataService
    private var cancellable = Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailsDataService(coin: coin)
        addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetails
            .sink { returnCoinDetails in
                print(returnCoinDetails)
            }
            .store(in: &cancellable)
    }
    
}
