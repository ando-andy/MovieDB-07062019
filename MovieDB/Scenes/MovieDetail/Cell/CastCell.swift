//
//  CastCellTableViewCell.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/09.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

final class CastCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    func bindingViewModel(_ castViewModel: CastMovieDetailViewModel?) {
        castNameLabel.text = castViewModel?.name
        castImage.sd_setImage(with: castViewModel?.profileImageURL, completed: nil)
    }
}
