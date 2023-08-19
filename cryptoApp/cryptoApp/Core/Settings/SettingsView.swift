//
//  SettingsView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import SwiftUI

struct SettingsView: View {
    private let ytUrl = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    var body: some View {
        NavigationStack{
            List {
                Section {
                    VStack(alignment: .leading){
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        Text("This app was made following the swiftfull think course on youtube")
                            .foregroundColor(Color.theme.accent)
                            .font(.callout)
                            .fontWeight(.medium)
                            .padding(.vertical)
                        Link("For more kindly follow 😊", destination: ytUrl)
                    }
                    .tint(.blue)
                    .font(.headline)
                } header: {
                    Text("Header")
                }

               
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading, content: {
                    XmarkButton()
                })}
          
        }
       
       
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
