//
//  StatisticView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import SwiftUI

struct StatisticView: View {
    let stat: StatisticsModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees:(stat.parcentageChange ?? 0) >= 0 ? 0 : 180 ))
                Text(stat.parcentageChange?.asPercentString() ?? "0.00")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.parcentageChange ?? 0) >= 0 ? Color.theme.greenColor : Color.theme.redColor)
            .opacity(stat.parcentageChange == nil ? 0.0 : 1.0)
        }
        
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            StatisticView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
            StatisticView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
