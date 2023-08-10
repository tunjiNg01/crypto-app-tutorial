//
//  CircleButtonView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
       Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background{
                Circle()
                    .fill(Color.theme.backgroundColor)
                
            }
            .shadow(color:Color.theme.accent.opacity(0.5), radius: 10, x:0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircleButtonView(iconName: "plus")
              .previewLayout(.sizeThatFits)
              
        }
       
    }
}
