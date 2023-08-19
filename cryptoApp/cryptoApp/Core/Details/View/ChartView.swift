//
//  ChartView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import SwiftUI

struct ChartView: View {
    let coin: CoinModel
    let data:[Double]
    init(coin: CoinModel) {
        self.coin = coin
        self.data = coin.sparklineIn7D?.price ?? []
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}
