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
        .refreshable {
            vm.reloadData()
        }
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
            HStackLayout(spacing: 4){
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .rank || vm.sortOptions == .rankReverse) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .rank ? 0: 180))
            }.onTapGesture {
                withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .rank ? .rankReverse : .rank
                }
               
            }
         
            Spacer()
            if(showPortfolio){
                HStackLayout(spacing: 4){
                    Text("Holding")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOptions == .holdings || vm.sortOptions == .holdingReverse) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOptions == .holdings ? 0: 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOptions = vm.sortOptions == .holdings ? .holdingReverse : .holdings
                    }
                   
                }
              
            }
            HStackLayout(spacing: 4){
              
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Button {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                } label: {
                    Image(systemName: "goforward")
                }
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOptions == .price || vm.sortOptions == .priceReverve) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOptions == .price ? 0: 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOptions = vm.sortOptions == .price ? .priceReverve : .price
                }
              
            }

        }
        .font(.caption)
            .foregroundColor(Color.theme.secondaryTextColor)
            .padding(.horizontal)
    }
}
