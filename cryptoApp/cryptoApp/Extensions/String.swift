//
//  String.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import Foundation

extension String {
    var removingHTMLOccurrence: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
