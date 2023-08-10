//
//  MainView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

struct MainView: View {
    @State private var showPortfolio: Bool = false
    var body: some View {
        ZStack{
            // backgroud layer
            Color.theme.backgroundColor
                .ignoresSafeArea()
            // content layer
            VStack{
                mainHead
                Spacer(minLength: 0)
               
            }
        }
      
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MainView()
                
        }
      
    }
}

extension MainView {
    private var mainHead: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus": "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
        Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180: 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
