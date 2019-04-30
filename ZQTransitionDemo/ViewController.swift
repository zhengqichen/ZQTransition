//
//  ViewController.swift
//  ZQTransitionDemo
//
//  Created by 雷丹 on 2019/4/30.
//  Copyright © 2019 CZQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(ZQTableViewController())
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        ///
//        let vc = ZQToViewController()
//        let nvc = UINavigationController(rootViewController: vc)
//        navigationController?.pushViewController(nvc, animated: true)
//    }

}

