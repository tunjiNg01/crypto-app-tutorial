//
//  CoinDetailsViewModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 18/08/2023.
//

import Foundation
import Combine


class CoinDetailsViewModel: ObservableObject {
    @Published var overviewStats: [StatisticsModel] = []
    @Published var additionalStats: [StatisticsModel] = []
    @Published var coin: CoinModel
    
    @Published var coinDescriptions: String?
    @Published var webUrl: String?
    @Published var redditUrl: String?
    
    private let coinDetailService: CoinDetailsDataService
    private var cancellable = Set<AnyCancellable>()
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailsDataService(coin: coin)
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        coinDetailService.$coinDetails.combineLatest($coin)
            .map(mapModelToStatisticsModel)
            .sink {[weak self] (returnCoinArrays) in
                self?.overviewStats = returnCoinArrays.overview
                self?.additionalStats = returnCoinArrays.additional
            }
            .store(in: &cancellable)
        
        coinDetailService.$coinDetails
            .sink { [weak self](returnedCoinDetails) in
                self?.coinDescriptions = returnedCoinDetails?.readableDescription
                self?.webUrl = returnedCoinDetails?.links?.homepage?.first
                self?.redditUrl = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellable)
    }
    
    
    
    
    private func mapModelToStatisticsModel(coinDetailModel:CoinDetailModel?, coinModel:CoinModel)  -> (overview: [StatisticsModel], additional: [StatisticsModel]) {
        let price = coinModel.currentPrice.setFormater()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticsModel(title: "Current price", value: price, parcentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticsModel(title: "Market Capitalization", value: marketCap, parcentageChange: marketCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticsModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticsModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticsModel] = [
           priceStat, marketCapStat, rankStat, volumeStat
        ]
        
        // additional
        
        let high = coinModel.high24H?.setFormater() ?? "n/a"
        let highStat = StatisticsModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.setFormater() ?? "n/a"
        let lowStat = StatisticsModel(title: "24h Low", value: low)
        
        let marketCapChange2 = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        
        let marketCapChangeStat = StatisticsModel(title: "24h Market Cap Change", value: marketCapChange2, parcentageChange: marketCapPercentChange)
        
        let priceChange = coinModel.priceChange24H?.formattedWithAbbreviations() ?? ""
        let pricePercentChange1 = coinModel.priceChangePercentage24H
        
        let priceChangeStat = StatisticsModel(title: "24h Price Change", value: priceChange, parcentageChange: pricePercentChange1)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString =  blockTime == 0 ? "n/a": "\(blockTime)"
        let blockStat = StatisticsModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticsModel(title: "Hashing Algorithhm", value: hashing)
        
        let additionalStat: [StatisticsModel] = [
            hashingStat, marketCapChangeStat, lowStat, highStat
            ,blockStat, priceChangeStat
        ]
        
        
        return (overviewArray, additionalStat)
    }
    
}
