//
//  SearchBarView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor( searchText.isEmpty ? Color.theme.secondaryTextColor : Color.theme.accent )
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundColor(Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accent)
                        .autocorrectionDisabled()
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endTextEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.theme.backgroundColor)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
