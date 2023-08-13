//
//  CoinsImageView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import SwiftUI

struct CoinsImageView: View {
    @StateObject var vm: CoinImageViewModel
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if(vm.isImageLoad){
            ProgressView()
        } else {
            Image(systemName: "questionmark")
        }
    }
}

struct CoinsImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsImageView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}
