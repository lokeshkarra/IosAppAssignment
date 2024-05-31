

import Combine
import Foundation

class LineChartViewModel: ObservableObject {
    @Published var clicksData: [ClicksData] = []

    private let lineChartModel = LineChartModel()

    func fetchChartsData() {
        let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew")!
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self?.clicksData = self?.lineChartModel.calculateClicksPerMonth(from: data) ?? []
                    print("Fetch called")
                }
            } else if let e = error {
                print("Error fetching data: \(e)")
            }
        }.resume()
    }
}
