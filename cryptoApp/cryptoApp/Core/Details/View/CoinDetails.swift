//
//  CoinDetails.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 17/08/2023.
//

import SwiftUI

struct CoinDetails: View {
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        print("I am coin \(coin.rank)")
    }
    var body: some View {
        Text(coin.name)
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetails(coin: dev.coin)
    }
}
