//
//  HapticManager.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 16/08/2023.
//

import Foundation
import SwiftUI

class HapticManager {
  static private let generator = UINotificationFeedbackGenerator()
    
   static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
