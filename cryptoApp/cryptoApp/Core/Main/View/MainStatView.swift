//
//  MainStatView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import SwiftUI

struct MainStatView: View {
    @EnvironmentObject private var vm: MainViemModel
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack{
            ForEach(vm.stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment:  showPortfolio ? .trailing : .leading)
    }
}

struct MainStatView_Previews: PreviewProvider {
    static var previews: some View {
        MainStatView(showPortfolio: .constant(false))
            .environmentObject(dev.mainVm)
    }
}
