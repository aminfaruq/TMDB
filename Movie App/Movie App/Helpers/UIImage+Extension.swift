//
//  UIImage+Extension.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import Foundation
import Combine
import UIKit

func tabBarImageFrom(_ value: UIImage?) -> UIImage {
    let tabBarImageView = TabBarImageView(frame: CGRect(x: 0, y: 0, width: 24.0, height: 24.0))
    tabBarImageView.imageView.image = value
    return tabBarImageView.asImage()
}

/// Only for tabbar image (with size = 24*24)
final class TabBarImageView: UIView {
    
    public let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
}

extension URL {
    func downloadImagePublisher() -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: self)
            .map(\.data)
            .mapError({ error in
                error as Error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


public struct ImageHelper {
    public static func getImagePublisher(url: String) -> AnyPublisher<UIImage, Error> {
        guard let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(url)") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return imageURL.downloadImagePublisher()
            .tryMap { data in
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "Image Conversion Error", code: 0, userInfo: nil)
                }
                return image
            }
            .eraseToAnyPublisher()
    }
}
