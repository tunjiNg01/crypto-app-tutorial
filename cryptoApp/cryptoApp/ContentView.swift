//
//  ContentView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 40){
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                Text("Secondary text")
                    .foregroundColor(Color.theme.secondaryTextColor)
                Text("Green Color")
                    .foregroundColor(Color.theme.greenColor)
                Text("Red Color")
                    .foregroundColor(Color.theme.redColor)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
