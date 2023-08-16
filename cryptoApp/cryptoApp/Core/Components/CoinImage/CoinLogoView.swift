//
//  CoinLogoView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 15/08/2023.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    var body: some View {
        VStack(spacing: 5) {
            CoinsImageView(coin: coin)
                .frame(width: 50, height: 40)
            Text(coin.symbol.uppercased())
                .foregroundColor(Color.theme.accent)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .font(.headline)
            Text(coin.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.theme.secondaryTextColor)
        }
      
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        CoinLogoView(coin: dev.coin)
    }
}
