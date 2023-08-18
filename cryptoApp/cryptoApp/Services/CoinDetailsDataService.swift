//
//  CoinDetailsDataService.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 18/08/2023.
//

import Foundation
import Combine


class CoinDetailsDataService {
    @Published var coinDetails: CoinDetailModel? = nil
   // var cancellable = Set<AnyCancellable>()
    
    var coinDetailsSubscriberCancelable: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinsDetailsData()
    }
    
    func getCoinsDetailsData(){
       // get the url
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
       else{ return }
        coinDetailsSubscriberCancelable = NetworkManager.download(url: url)
           .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
           .sink(receiveCompletion: NetworkManager.CompletionHandler , receiveValue: { [weak self](returnedCoinsDetail) in
                 self?.coinDetails = returnedCoinsDetail
                 self?.coinDetailsSubscriberCancelable?.cancel()
           })
    }
}
