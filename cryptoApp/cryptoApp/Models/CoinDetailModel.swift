//
//  CoinDetailModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 17/08/2023.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 */

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

struct CoinDetailModel: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
            case id, symbol, name, description, links
            case blockTimeInMinutes = "block_time_in_minutes"
            case hashingAlgorithm = "hashing_algorithm"
        }

}

struct Description: Codable {
    let en: String?
}


struct DetailPlatforms {
    let empty: Empty?
}

struct Empty {
    let decimalPlace: NSNull?
    let contractAddress: String?
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
           case homepage
           case subredditURL = "subreddit_url"
       }
}

