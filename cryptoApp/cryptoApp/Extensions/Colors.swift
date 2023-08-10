//
//  Colors.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}


struct ColorTheme {
    let accent = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let greenColor = Color("GreenColor")
    let redColor = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}
