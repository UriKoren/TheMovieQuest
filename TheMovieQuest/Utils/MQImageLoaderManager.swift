//
//  MQmageLoaderManager.swift
//  TheMovieQuest
//
//  Created by Uri Koren on 04/05/2024.
//

import UIKit

class MQImageLoaderManager {
    private var imageCache = [URL: CachedImage]()
    
    struct CachedImage {
        let image: UIImage
        let expirationDate: Date
    }
    
    /**
     Loads an image asynchronously from the specified URL, utilizing a cache to optimize performance.

     - Parameters:
       - url: The URL from which to load the image.
       - completion: A closure that receives the loaded `UIImage?` when the image loading is complete.

     This method checks a local cache (`imageCache`) first to determine if the requested image has been previously loaded and is still valid (not expired). If a cached image exists and is not expired, it is returned immediately without initiating a network request. If no cached image is found or it has expired, the method fetches the image data from the provided URL using a URLSession data task. Upon successful retrieval, the image is cached with an expiration time of 1 day to optimize subsequent requests.
     */
    func loadImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else {
            completion(nil)
            return
        }
        
        // Check if image exists in cache and is not expired
        if let cachedImage = imageCache[url], cachedImage.expirationDate > Date() {
            completion(cachedImage.image)
            return
        }
        
        // Create a URLSession task to fetch the image data
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Ensure data is received
            guard let imageData = data, let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            
            // Cache the image with expiration time (1 day)
            let expirationDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
            let cachedImage = CachedImage(image: image, expirationDate: expirationDate)
            self?.imageCache[url] = cachedImage
            
            completion(image)
        }.resume()
    }
}
