//
//  RepositoryCell.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import UIKit

class RepositoryCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var createdAtLabel: UILabel!
    @IBOutlet var stargazersCountLabel: UILabel!

    class var identifier: String { return String(describing: self) }

    var repository: Repository? {
        didSet {
            if let repository = repository {
                nameLabel.text = repository.name
                descriptionLabel.text = repository.description
                createdAtLabel.text = repository.createdAt.shortDateString
                stargazersCountLabel.text =  "\(repository.stargazersCount)"
            }

        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        descriptionLabel.text = nil
        createdAtLabel.text = nil
        stargazersCountLabel.text = nil
    }
}
