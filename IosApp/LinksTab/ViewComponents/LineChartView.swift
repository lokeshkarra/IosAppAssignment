

import SwiftUI
import Charts
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM"
    return formatter
}()

struct LineChartView: View {
    @ObservedObject var viewModel = LineChartViewModel()

    var body: some View {
        VStack {
            HStack {
                Text("Overview")
          .font(.system(size: 14, weight: .regular))
          .foregroundColor(Color.gray)
          .padding(.leading)
                Spacer()
                Button(action: {
                    // Action for date selection
                }) {
                    HStack {
                        Text("21 Dec - 23 Sep")
                        Image(systemName: "clock")
                    }
                }
        .font(.system(size: 12, weight: .regular))
        .foregroundColor(.black)
        .padding(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray))
        .padding(.trailing)
            }
      .padding(.vertical)

            Chart {
                ForEach(viewModel.clicksData) { item in
    LineMark(
        x: .value("Date", item.date),
        y: .value("Clicks", item.clicks)
    )
          .foregroundStyle(Color.blue)
                    AreaMark(
                        x: .value("Date", item.date),
                        y: .value("Clicks", item.clicks)
                    )
          .foregroundStyle(LinearGradient(
            gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.blue.opacity(0.1)]),
            startPoint: .top,
            endPoint: .bottom
          ))
                    
                    //print("Area Mark Completed")
                }
                
                
            }.chartXAxis {
                AxisMarks(values: .stride(by: .month, count: 2)) { value in
    AxisGridLine()
                    AxisValueLabel {
                        if let date = value.as(Date.self) {
                            Text(dateFormatter.string(from: date))
                        }
                    }
                }
            }
      .chartYAxis { AxisMarks(position: .leading) }
      .padding(.horizontal)
      .frame(height: 125)
        }
    .padding(.bottom)
    .background(.white)
    .cornerRadius(10)
    .onAppear {
        viewModel.fetchChartsData()
        print("Fetching Chart Data")
    }
    }
}

struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView()
    }
}
