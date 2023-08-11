//
//  Double.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 11/08/2023.
//


import Foundation
extension Double {
    
    
    /// Convert double to a currency format
    /// ```
    /// Convert 12500.5677 to $ 12,500.56
    /// Convert 12.5677 to $ 12.56
    /// ```
    private var numberFormater: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
        formater.locale = .current
        formater.currencyCode = "usd"
        formater.currencyCode = "$"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        return formater
    }
    
    /// Convert double to a currency format to string in to 2-6
    /// ```
    /// Convert 12500.5677 to "$ 12,500.56"
    /// Convert 12.5677 to "$ 12.56"
    /// ```
    
    public func setFormater() -> String {
        let number = NSNumber(value: self)
        return numberFormater.string(from: number) ?? "$0.00"
    }
    
    /// Convert double to a percent string
    /// ```
    /// Convert 1.5677 to "$ 1.56"
    /// ```
    public func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert double to a percent string with percentage symbol
    /// ```
    /// Convert 1.5677 to "1.56 %"
    /// ```
    public func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
