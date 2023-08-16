//
//  MainView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var vm: MainViemModel
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    var body: some View {
        ZStack{
            // backgroud layer
            Color.theme.backgroundColor
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            // content layer
            VStack{
                mainHead
                MainStatView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
               columnsTitle
                if (!showPortfolio){
                    allCoinList
                    .transition(.move(edge: .leading))
                }
                
                if(showPortfolio){
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
               
            }
        }
      
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
                .environmentObject(dev.mainVm)
                
        }
      
    }
}

extension MainView {
    private var mainHead: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus": "info")
                .onTapGesture {
                    if(showPortfolio){
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
        Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180: 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinList: some View {
        List {
            ForEach(vm.allCoin){ coin in
                CoinRowView(coin: coin, showHolding: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoin){ coin in
                CoinRowView(coin: coin, showHolding: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    private var columnsTitle: some View {
        HStack {
            Text("Coin")
            Spacer()
            if(showPortfolio){
                Text("Holding")
            }
          
            Text("Portfolio")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
            .foregroundColor(Color.theme.secondaryTextColor)
            .padding(.horizontal)
    }
}
