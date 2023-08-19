//
//  Date.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import Foundation


extension Date {
    init(coinDateString: String){
        let formater = DateFormatter()
        formater.dateFormat = "YYY-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formater.date(from: coinDateString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    private var shortFormater: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .short
        return formater
    }
    
    func asShortDateString() -> String {
        return shortFormater.string(from: self)
    }
}
