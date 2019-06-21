//
//  EmptyDataView.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/06/20.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

final class EmptyDataView: UIView, NibOwnerLoadable {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    
}
