

import SwiftUI
import Charts

struct ClicksData: Identifiable {
    let id = UUID()
    let date: Date
    let clicks: Double
 
    init(month: Int, day: Int, clicks: Double) {
        self.date = Calendar.current.date(from: .init(month: month, day: day)) ?? Date()
        self.clicks = clicks
    }
}

struct SampleLineChartView: View {
    let sampleClicksData = [ ClicksData(month: 1, day: 1, clicks: 25),
                              ClicksData(month: 2, day: 1, clicks: 36),
                              ClicksData(month: 3, day: 1, clicks: 52),
                              ClicksData(month: 4, day: 1, clicks: 86),
                              ClicksData(month: 5, day: 1, clicks: 100),
                              ClicksData(month: 6, day: 1, clicks: 25.0),
                              ClicksData(month: 7, day: 1, clicks: 50),
                              ClicksData(month: 8, day: 1, clicks: 25),
                             ClicksData(month: 9, day: 1, clicks: 100)
                                ]
    
    var body: some View {
        VStack {
            HStack {
                 Text("Overview")
                    .font(.figtree(size: 14, weight: .regular))
                    .foregroundColor(Color.secondaryForeground)
                     .padding(.leading)
                 Spacer()
                HStack {
                    Text("22 Aug - 23 Sep")
                    Image(systemName: "clock")
                }
                    .font(.figtree(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .padding(6)
                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.secondaryForeground))
                    .padding(.trailing)
             }
             .padding(.vertical)
            Chart {
                ForEach(sampleClicksData) { item in
                    LineMark(
                        x: .value("Month", item.date),
                        y: .value("Clicks", item.clicks)
                    )
                    .foregroundStyle(Color.blue)
                    AreaMark(
                        x: .value("Month", item.date),
                        y: .value("Clicks", item.clicks)
                    )
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.blue.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                }
            }
            .chartYAxis { AxisMarks(position: .leading) }
            .padding(.horizontal)
            .frame(height: 200)
        }
        .padding(.bottom)
        .background(.white)
        .cornerRadius(10)
    }
}

struct SampleChartsView_Previews: PreviewProvider {
    static var previews: some View {
        SampleLineChartView()
    }
}
