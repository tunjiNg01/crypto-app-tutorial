//
//  UIApplication.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endTextEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
