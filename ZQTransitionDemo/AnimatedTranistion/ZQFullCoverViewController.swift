//
//  ZQFullCoverViewController.swift
//  ZQTransitionDemo
//
//  Created by 雷丹 on 2019/4/30.
//  Copyright © 2019 CZQ. All rights reserved.
//

import UIKit

class ZQFullCoverToViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let titleLabel = UILabel(frame: view.bounds)
        titleLabel.textAlignment = .center
        titleLabel.text = "右滑返回"
        view.addSubview(titleLabel)
    }
}

