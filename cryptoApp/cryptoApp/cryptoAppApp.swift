//
//  cryptoAppApp.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

@main
struct cryptoAppApp: App {
    @StateObject private var mainVm = MainViemModel()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView()
                   
            }
            .environmentObject(mainVm)
           
        }
    }
}
