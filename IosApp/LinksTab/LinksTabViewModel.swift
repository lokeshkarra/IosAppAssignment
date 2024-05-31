/*
import Foundation
import Combine

class LinksTabViewModel: ObservableObject {

    @Published var topLinks: [LinkItemModel] = []
    @Published var recentLinks: [LinkItemModel] = []
    @Published var stats: [StatsData] = []
    @Published var isLoading = false  // Make isLoading a @Published property
    @Published var showError = false
    
    func fetchLinksData() {
        isLoading = true
        let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew")!
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if String(data: data, encoding: .utf8) != nil {
                    DispatchQueue.main.async {
                        print("Api response received")
                    }
                }
                do {
                    let userData = try JSONDecoder().decode(UserDataNetworkResponseModel.self, from: data)
                    
                    DispatchQueue.main.async { [self] in
                        updateLinks(with: userData)
                        updateStatistics(with: userData)
                        isLoading = false
                    }
                    
                    
                    
                } catch {
                    print("Error decoding the JSON: \(error)")
                    self.showError = true
                }
            } else if let e = error {
                print("Error fetching data: \(e)")
                self.showError = true
            }
        } .resume()
    }
    
    private func updateLinks(with userData: UserDataNetworkResponseModel) {
        if let topLinksList = userData.data?.top_links {
            topLinks = topLinksList.map { each in
                LinkItemModel(
                    title: each.title ?? "",
                    totalClicks: each.total_clicks ?? 0,
                    originaImage: each.original_image,
                    displayDate: formatDateString(each.created_at ?? ""),
                    linkURL: each.web_link ?? ""
                )
            }
        }

        if let recentLinksList = userData.data?.recent_links {
            recentLinks = recentLinksList.map { each in
                LinkItemModel(
                    title: each.title ?? "",
                    totalClicks: each.total_clicks ?? 0,
                    originaImage: each.original_image,
                    displayDate: formatDateString(each.created_at ?? ""),
                    linkURL: each.web_link ?? ""
                )
            }
        }
    }

    private func updateStatistics(with userData: UserDataNetworkResponseModel) {
        let clicks = StatsData(type: .clicks, value: String(userData.today_clicks ?? 0))
        let topLocation = StatsData(type: .topLocation, value: userData.top_location ?? "")
        let topSource = StatsData(type: .topSource, value: userData.top_source ?? "")
        stats = [clicks, topLocation, topSource]
        CommonData.sharedVariables.whatsappNumber = userData.support_whatsapp_number ?? ""
    }
    
    
    

    func formatDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
}
*/


import Foundation
import Combine

class LinksTabViewModel: ObservableObject {
    @Published var topLinks: [LinkItemModel] = []
    @Published var recentLinks: [LinkItemModel] = []
    @Published var stats: [StatsData] = []
    @Published var isLoading = false
    @Published var showError = false

    private var cancellables = Set<AnyCancellable>()
    
    func fetchLinksData() {
        print("Fetching data...")
        DispatchQueue.main.async {
            self.isLoading = true
        }
        showError = false

        let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew")!
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: UserDataNetworkResponseModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        print("Error fetching data: \(error)")
                        self?.showError = true
                    }
                }
            }, receiveValue: { [weak self] userData in
                print("Data fetched successfully")
                self?.updateLinks(with: userData)
                self?.updateStatistics(with: userData)
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            })
            .store(in: &cancellables)
    }
    
    private func updateLinks(with userData: UserDataNetworkResponseModel) {
        if let topLinksList = userData.data?.top_links {
            topLinks = topLinksList.map { each in
                LinkItemModel(
                    title: each.title ?? "",
                    totalClicks: each.total_clicks ?? 0,
                    originaImage: each.original_image,
                    displayDate: formatDateString(each.created_at ?? ""),
                    linkURL: each.web_link ?? ""
                )
            }
        }

        if let recentLinksList = userData.data?.recent_links {
            recentLinks = recentLinksList.map { each in
                LinkItemModel(
                    title: each.title ?? "",
                    totalClicks: each.total_clicks ?? 0,
                    originaImage: each.original_image,
                    displayDate: formatDateString(each.created_at ?? ""),
                    linkURL: each.web_link ?? ""
                )
            }
        }
    }

    private func updateStatistics(with userData: UserDataNetworkResponseModel) {
        let clicks = StatsData(type: .clicks, value: String(userData.today_clicks ?? 0))
        let topLocation = StatsData(type: .topLocation, value: userData.top_location ?? "")
        let topSource = StatsData(type: .topSource, value: userData.top_source ?? "")
        stats = [clicks, topLocation, topSource]
        CommonData.sharedVariables.whatsappNumber = userData.support_whatsapp_number ?? ""
    }

    func formatDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMM yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
}
