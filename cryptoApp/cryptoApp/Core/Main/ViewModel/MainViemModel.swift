//
//  MainViemModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation


class MainViemModel: ObservableObject {
    @Published var allCoin: [CoinModel] = []
    @Published var portfolioCoin: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.allCoin.append(DeveloperPreview.instance.coin)
            self.portfolioCoin.append(DeveloperPreview.instance.coin)
        }
       
    }
}
