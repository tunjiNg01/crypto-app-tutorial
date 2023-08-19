//
//  LaunchView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadText: [String] = "Loading your portfolio...".map {String($0)}
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    let timer = Timer.publish(every: 0.1, on: .main, in:
            .common).autoconnect()
    var body: some View {
        ZStack{
            Color.theme.launchbackground
                .ignoresSafeArea()
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack {
                if showLoadingText {
                  //  Text(loadText)
                       
                       //
                       
                    HStack(spacing: 0){
                        ForEach(loadText.indices) { index in
                            Text(loadText[index])
                                .fontWeight(.heavy)
                                .font(.headline)
                                .foregroundColor(Color.theme.launchAccent)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }.transition(AnyTransition.scale.animation(.easeIn))
                }
             
            }.offset(y:70)
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        showLaunchView = false
                    }
                }else {
                    counter += 1
                }
             
            }
        }
        
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
