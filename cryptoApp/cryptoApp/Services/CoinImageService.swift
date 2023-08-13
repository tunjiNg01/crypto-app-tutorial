//
//  CoinImageService.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?
    private var coinImageCancellable: AnyCancellable?
    private var coin: CoinModel
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        // get the url
        guard let url = URL(string: coin.image)
        else{ return }
        coinImageCancellable = NetworkManager.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.CompletionHandler , receiveValue: { [weak self](returnedImage) in
                self?.image = returnedImage
                self?.coinImageCancellable?.cancel()})
    }
    
}
