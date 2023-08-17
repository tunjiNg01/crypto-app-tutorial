//
//  MarketDataServices.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 15/08/2023.
//

import Foundation
import Combine


class MarketDataServices {
    @Published var marketData:MarketDataModel? = nil
   // var cancellable = Set<AnyCancellable>()
    
    var marketDataSubscriberCancelable: AnyCancellable?
    
    init(){
        getData()
    }
    
 func getData(){
       // get the url
      guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
       else{ return }
       marketDataSubscriberCancelable = NetworkManager.download(url: url)
           .decode(type: GlobalData.self, decoder: JSONDecoder())
           .sink(receiveCompletion: NetworkManager.CompletionHandler , receiveValue: { [weak self](returnedMarketData) in
               self?.marketData = returnedMarketData.data
                 self?.marketDataSubscriberCancelable?.cancel()
               
           })
        
    }
}
