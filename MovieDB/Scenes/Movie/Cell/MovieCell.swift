//
//  MovieCell.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/19.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    func bindViewModel(_ viewModel: MovieViewModel?) {
        moviePosterImage.sd_setImage(with: viewModel?.posterImageURL, completed: nil)
    }
}
