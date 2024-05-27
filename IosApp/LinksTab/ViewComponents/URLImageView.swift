

import Foundation
import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageLoader: URLImageLoader
    
    init(urlString: String) {
        urlImageLoader = URLImageLoader(urlString: urlString)
    }
    var body: some View {
        if let image = urlImageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        else {
            Image(.source)
                .resizable()
                .scaledToFit()
        }
    }
}

class URLImageLoader : ObservableObject {
    @Published var image: UIImage?
    var urlString : String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        loadImageFromUrl()
    }
    
    func loadImageFromUrl() {
        guard let urlString = urlString else {
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        if urlString != nil {
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.image = loadedImage
            }
        }
        
    }
}
