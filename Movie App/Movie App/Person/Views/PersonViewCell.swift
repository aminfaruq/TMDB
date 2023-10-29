//
//  PersonViewCell.swift
//  Movie App
//
//  Created by Phincon on 29/10/23.
//

import UIKit
import Combine

class PersonViewCell: UITableViewCell {

    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personKnowAsLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    private var cancellables: Set<AnyCancellable> = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(data: Actor) {
        cardView.backgroundColor = UIColor(hex: "F5F7F8")
        cardView.setCornerRadius(radius: 12)
        personNameLabel.text = data.name
        personImage.image = nil

        let knownForTitles = data.knownFor?.compactMap { $0.originalTitle } ?? []
        personKnowAsLabel.text = knownForTitles.joined(separator: ", ")

        ImageHelper.getImagePublisher(url: data.profilePath ?? "")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            }, receiveValue: { image in
                self.personImage.image = image
            })
            .store(in: &cancellables)
    }
    
}
