

import Foundation
import SwiftUI

class HorizontalScrollStatsCardModel: Codable {
    
    internal init(image: String, value: String, title: String) {
        self.image = image
        self.value = value
        self.title = title
    }
    
    var image: String
    var value: String
    var title: String
}

struct ButtonModel {
    var image: ImageResource
    var name: String
}

class CustomerSupportCardModel: Codable {
    internal init(image: String, name: String, background: String, borderColor: String) {
        self.image = image
        self.name = name
        self.background = background
        self.borderColor = borderColor
    }
    
    var image: String
    var name: String
    var background: String
    var borderColor: String
}

class UserDataNetworkResponseModel: Codable {
    var status: Bool?
    var statusCode: Int?
    var message: String?
    var support_whatsapp_number: String?
    var extra_income: Double?
    var total_links: Int?
    var total_clicks: Int?
    var today_clicks: Int?
    var top_source: String?
    var top_location: String?
    var startTime: String?
    var links_created_today: Int?
    var applied_campaign: Int?
    var data: UserDataModel?
}

class UserDataModel: Codable {
    var recent_links: [LinksModel]?
    var top_links: [LinksModel]?
}

class LinksModel: Codable {
    var url_id: Int?
    var web_link: String?
    var smart_link: String?
    var title: String?
    var total_clicks: Int?
    var original_image: String?
    var thumbnail: String?
    var times_ago: String?
    var created_at: String?
    var domain_id: String?
    var url_prefix: String?
    var url_suffix: String?
    var app: String?
}

struct LinkItemModel: Codable, Hashable {
    internal init(title: String, totalClicks: Int, originaImage: String? = nil, displayDate: String, linkURL: String) {
        self.title = title
        self.totalClicks = totalClicks
        self.originaImage = originaImage
        self.displayDate = displayDate
        self.linkURL = linkURL
    }
    
    var title: String
    var totalClicks: Int
    var originaImage: String?
    var displayDate: String
    var linkURL: String
}

class StatsModel: Codable {
    internal init(todaysClicks: String, topLocation: String, topSource: String) {
        self.todaysClicks = todaysClicks
        self.topLocation = topLocation
        self.topSource = topSource
    }
    
    var todaysClicks: String
    var topLocation: String
    var topSource: String
}

struct StatsData: Codable, Hashable {
    var type: Stats
    var value: String
}
