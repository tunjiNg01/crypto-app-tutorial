//
//  CoindataServices.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 13/08/2023.
//

import Foundation
import Combine


class CoindataServices {
    @Published var allCoins:[CoinModel] = []
   // var cancellable = Set<AnyCancellable>()
    
    var coinSubscriberCancelable: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    func getCoins(){
       // get the url
      guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
       else{ return }
       coinSubscriberCancelable = NetworkManager.download(url: url)
           .decode(type: [CoinModel].self, decoder: JSONDecoder())
           .sink(receiveCompletion: NetworkManager.CompletionHandler , receiveValue: { [weak self](returnedCoins) in
                 self?.allCoins = returnedCoins
                 self?.coinSubscriberCancelable?.cancel()})
        
    }
}
