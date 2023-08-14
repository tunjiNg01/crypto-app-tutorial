//
//  StatisticsModel.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import Foundation

struct StatisticsModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let parcentageChange: Double?
    
    init(title: String, value: String, parcentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.parcentageChange = parcentageChange
    }
}
