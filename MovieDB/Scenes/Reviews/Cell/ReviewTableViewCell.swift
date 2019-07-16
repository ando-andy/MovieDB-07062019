//
//  ReviewTableViewCell.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/12.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

final class ReviewTableViewCell: UITableViewCell, NibReusable {

    // MARK: - IBOutlets
    @IBOutlet weak var reviewerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func bindViewModel(_ reviewViewModel: ReviewViewModel?) {
        reviewerLabel.text = reviewViewModel?.author ?? ""
        contentLabel.text = reviewViewModel?.content ?? ""
    }
}
