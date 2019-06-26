//
//  CategoriesTableViewCell.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/25.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell, NibReusable {

// MARK: - IBOutlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func bindViewModel(_ viewModel: MovieViewModel?) {
        nameLabel.text = viewModel?.name ?? ""
        posterImage.sd_setImage(with: viewModel?.posterImageURL, completed: nil)
    }
}
