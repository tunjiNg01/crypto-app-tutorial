//
//  CoinDetails.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 17/08/2023.
//

import SwiftUI

struct CoinDetails: View {
    @StateObject private var vm: CoinDetailsViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
     ]
    let coin: CoinModel
    private let spacing: Double = 20
    
    init(coin: CoinModel) {
        self.coin = coin
        self._vm = StateObject(wrappedValue: CoinDetailsViewModel(coin: coin))
    }
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("Chart")
                    .frame(height: 150)
                overText
                Divider()
                overviewStatGrid
                additionalText
                Divider()
                additionalStatGrid
            }
            .padding()
            .navigationTitle(coin.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                   topbarTrailingItem
                }
            }
        }
    }
}

struct CoinDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CoinDetails(coin: dev.coin)
        }
      
    }
}

extension CoinDetails {
    private var overText: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalText: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var  overviewStatGrid: some
    View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStats) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalStatGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.additionalStats) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var topbarTrailingItem: some View {
        HStack(){
            Text(vm.coin.symbol.uppercased())
                .foregroundColor(Color.theme.secondaryTextColor)
                .font(.headline)
            CoinsImageView(coin: vm.coin)
                .frame(width: 25)
        }
    }
}
