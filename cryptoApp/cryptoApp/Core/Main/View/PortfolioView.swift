//
//  PortfolioView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 15/08/2023.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: MainViemModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantity = ""
    @State private var showCheckmark = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinList
                    Spacer(minLength: 50)
                    if(selectedCoin != nil){
                       selectedCoinInput
                    }
                   
                }
            }
            .navigationTitle("Edit Portfolio")
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                   XmarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavButtons
                }
            }
            
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.mainVm)
    }
}

extension PortfolioView{
    private var coinList: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoin) { coin in
                   CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background{
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.greenColor : Color.clear, lineWidth:  1)
                        }
                }
            }
            .padding(.leading)
           
            
        }
    }
    
    private var selectedCoinInput: some View {
        VStack {
            HStack{
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.setFormater() ?? "0.00")
            }
            Divider()
            HStack{
                Text("Amount in portfolio:")
                 
                Spacer()
                TextField("Ex.. 12.34", text: $quantity)
                    .multilineTextAlignment(.trailing)
                   
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current value")
                Spacer()
                Text(getCurrentValue().setFormater())
            }
        }
        .font(.headline)
        .padding()
    }
    
    private var trailingNavButtons: some View {
        HStack{
            Image(systemName: "checkmark")
                .opacity( showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
            }.opacity(selectedCoin != nil && selectedCoin?.currentholding != Double(quantity) ? 1.0 : 0.0 )

           
                
        }.font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantity) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private func saveButtonPressed() {
        guard let coin = selectedCoin else {return}
        
        // show checkmark
        withAnimation {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        
        UIApplication.shared.endTextEditing()
        
        // hide save button
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation {
                showCheckmark = false
            }
        }
    }
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
