//
//  CoinDetails.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 17/08/2023.
//

import SwiftUI

struct CoinDetails: View {
    @StateObject private var vm: CoinDetailsViewModel
    @State private var showFullDescription: Bool = false
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
            VStack {
                ChartView(coin: vm.coin)
                VStack(spacing: 20){
                    overText
                    Divider()
                    descriptionText
                    
                    overviewStatGrid
                    additionalText
                    Divider()
                    additionalStatGrid
                    webSection
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .tint(.blue)
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
    
    private var descriptionText: some
    View {
        ZStack{
            if let coinDescription = vm.coinDescriptions, !coinDescription.isEmpty {
                
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryTextColor)
                        .lineLimit(showFullDescription ? nil : 3)
                    Button {
                        withAnimation(.easeOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? " Show less..." : "Read more...")
                            .font(.caption)
                            .bold()
                            .foregroundColor(.blue)
                            .padding(.vertical, 2)
                    }
                    

                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    private var webSection: some View {
        VStack(alignment: .leading, spacing:15){
            if let webstring = vm.webUrl, let url = URL(string: webstring){
                Link("Website", destination: url)
            }
            if let reditstring = vm.redditUrl, let url = URL(string: reditstring){
                Link("Reddit url", destination: url)
            }
        }
    }
}
