//
//  CoinRowView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 11/08/2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHolding: Bool
    var body: some View {
        HStack(spacing: 0){
            leftSideColumn
            Spacer()
            if showHolding {
                centerColumn
            }
           rightSideColumn
            
        }.font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CoinRowView(coin: dev.coin, showHolding: true)
                .previewLayout(.sizeThatFits)
            CoinRowView(coin: dev.coin, showHolding: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}

extension CoinRowView {
    private var leftSideColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            Circle()
                .frame(width: 30)
            Text(coin.symbol.uppercased())
                .bold()
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingValue.setFormater())
                .bold()
            Text((coin.currentholding ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var rightSideColumn: some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.setFormater())
                .bold()
                .foregroundColor(Color.theme.accent)
                
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "" )
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
