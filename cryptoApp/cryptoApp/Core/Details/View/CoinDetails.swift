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
    
    init(coin: CoinModel) {
        
        self.coin = coin
        print("I am coin \(coin.rank)")
        
        self._vm = StateObject(wrappedValue: CoinDetailsViewModel(coin: coin))
    }
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("Chart")
                    .frame(height: 150)
                Text("Overview")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                LazyVGrid(columns: columns,
                          alignment: .center,
                          spacing: nil,
                          pinnedViews: []) {
                    Text("Column 1")
                    Text("Column 2")
                }
                Text("Additional Details")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.theme.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .navigationTitle(coin.name)
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
