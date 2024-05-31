

import Foundation

// Define the structures to match the JSON response
struct ApiResponse: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let recentLinks: [Link]
    let topLinks: [Link]

    enum CodingKeys: String, CodingKey {
        case recentLinks = "recent_links"
        case topLinks = "top_links"
    }
}

struct Link: Codable {
    let totalClicks: Int
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case totalClicks = "total_clicks"
        case createdAt = "created_at"
    }
}

// Define the ClicksData structure
struct ClicksData: Identifiable {
    let id = UUID()
    let month: Int
    let year: Int
    let clicks: Int
    
    var date: Date {
        let calendar = Calendar.current
        return calendar.date(from: DateComponents(year: year, month: month)) ?? Date()
    }
}

// Define the LineChartModel structure
class LineChartModel {
    
    
    func calculateClicksPerMonth(from jsonData: Data) -> [ClicksData] {
        let decoder = JSONDecoder()
        var clicksDataArray: [ClicksData] = []

        do {
            let apiResponse = try decoder.decode(ApiResponse.self, from: jsonData)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            var clicksPerMonth: [String: Int] = [:]
            let allLinks = apiResponse.data.recentLinks + apiResponse.data.topLinks

            for link in allLinks {
                if let date = dateFormatter.date(from: link.createdAt) {
                    let yearMonth = Calendar.current.dateComponents([.year, .month], from: date)
                    let monthKey = "\(yearMonth.year!)-\(String(format: "%02d", yearMonth.month!))"
                    clicksPerMonth[monthKey, default: 0] += link.totalClicks
                }
            }

            let sortedClicksPerMonth = clicksPerMonth.sorted(by: { $0.key < $1.key })

            for (monthKey, clicks) in sortedClicksPerMonth {
                let components = monthKey.split(separator: "-")
                if let year = Int(components[0]), let month = Int(components[1]) {
                    clicksDataArray.append(ClicksData(month: month, year: year, clicks: clicks))
                    print("ClicksData(month: \(month), year: \(year), clicks: \(clicks))")
                }
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }

        return clicksDataArray
    }}

