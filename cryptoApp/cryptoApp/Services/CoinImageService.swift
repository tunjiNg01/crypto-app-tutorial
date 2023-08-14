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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_image"
    private let imageName: String
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(folderName: folderName, imageName: imageName){
            image = savedImage
            print("got image from file")
        }else {
            downloadCoinImage()
            print("Downloading image now")
        }
    }
    
    private func downloadCoinImage() {
      
        // get the url
        guard let url = URL(string: coin.image)
        else{ return }
        coinImageCancellable = NetworkManager.download(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.CompletionHandler , receiveValue: { [weak self](returnedImage) in
                guard let self = self, let downLoadedImage = returnedImage else {return}
                self.image = downLoadedImage
                self.coinImageCancellable?.cancel()
                self.fileManager.saveImage(image: downLoadedImage , folderName: self.folderName, imageName: self.imageName)
                
            })
               
    }
    
}
