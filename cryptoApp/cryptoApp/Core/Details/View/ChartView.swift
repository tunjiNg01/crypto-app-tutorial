//
//  ChartView.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 19/08/2023.
//

import SwiftUI

struct ChartView: View {
    private let coin: CoinModel
    private let data:[Double]
    
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage:CGFloat = 0
    init(coin: CoinModel) {
        self.coin = coin
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        self.lineColor = priceChange > 0 ? Color.theme.greenColor : Color.theme.redColor
        self.endingDate = Date(coinDateString: coin.lastUpdated ?? "")
        self.startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
       
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
            .overlay(chartPrice,alignment: .leading)
            .padding(.horizontal, 4)
            chartDateLabels.padding(.horizontal, 4)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                withAnimation(.linear(duration: 3)) {
                    percentage = 1
                }
            }
        }
        
       
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
           
    }
}


extension ChartView  {
    private var chartView: some View {
        GeometryReader { geometry in
            Path{
                path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
                
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 34)
        }
    }
    
    private var chartBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartPrice: some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            let midPrice = (maxY + minY)/2
            Spacer()
            Text(midPrice.formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
        .foregroundColor(Color.theme.accent)
        .font(.caption)
    }
    private var chartDateLabels: some View {
        HStack{
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
        .foregroundColor(Color.theme.accent)
        .font(.caption)
    }
}
