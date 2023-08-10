//
//  CircleButtonAnimationView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 10/08/2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding  var animate: Bool;
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 4): .none, value: 1)
            
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate:  .constant(false))
            .frame(width: 100, height: 100)
    }
}
