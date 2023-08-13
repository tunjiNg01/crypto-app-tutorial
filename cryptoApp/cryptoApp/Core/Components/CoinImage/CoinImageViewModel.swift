//
//  CoinImageViewModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import SwiftUI
import Combine


class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isImageLoad: Bool = false
    let coin: CoinModel
    let dataService: CoinImageService
    var imageCancellable = Set<AnyCancellable>()
    init(coin: CoinModel){
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber(){
        dataService.$image
            .sink { [weak self](_) in
                self?.isImageLoad = false
            } receiveValue: {[weak self] (returnedImage) in
                self?.image = returnedImage
            }.store(in: &imageCancellable)

    }
}

