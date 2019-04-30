//
//  ZQTableViewController.swift
//  ZQTransitionDemo
//
//  Created by 雷丹 on 2019/4/30.
//  Copyright © 2019 CZQ. All rights reserved.
//

import UIKit

class ZQTableViewController: UITableViewController {
    let dataArray = ["默认模态转场，目标控制器从底部划出",
                     "翻页效果",
                     "渐变效果",
                     "正反面效果",
                     "默认模态转场，同第一个",
                     "push动画转场（支持右滑返回）",
                     "自定义转场",
    ]
    // 动画
    let tranistionHandler = ZQFullCoverAnimatedTranistion()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return dataArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///
        let vc = ZQToViewController()
        
        switch indexPath.row {
        case 0:
            // 默认模态转场，目标控制器从底部划出
            present(vc, animated: true, completion: nil)
            break
        case 1:
            // 翻页效果
            vc.modalTransitionStyle = .partialCurl
            present(vc, animated: true, completion: nil)
            break
        case 2:
            // 渐变效果
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
            break
        case 3:
            // 切换正反面效果
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true, completion: nil)
            break
        case 4:
            // 默认模态转场，同第一个
            vc.modalTransitionStyle = .coverVertical
            present(vc, animated: true, completion: nil)
            break
        case 5:
            // push动画转场,支持右滑返回,当前控制器不是navigationController的子控制器时无效
            let vc = ZQToViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 6:
            let vc = ZQFullCoverToViewController()
            vc.transitioningDelegate = self
            // 开启右滑返回
            tranistionHandler.usingLeftSwipDismiss(view: vc.view)
            present(vc, animated: true, completion: nil)
            break
        case 7:
            break
        default:
            break
        }
    }
}


extension ZQTableViewController:UIViewControllerTransitioningDelegate{
    
    /// 弹出
    ///
    /// - Parameters:
    ///   - presented: 目标
    ///   - presenting: 当前
    ///   - source: 资源
    /// - Returns: 自定义的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return tranistionHandler
    }
    
    /// 收起
    ///
    /// - Parameter dismissed: 目标
    /// - Returns: 自定义的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return tranistionHandler
    }
    
    /// 响应手势操作
    ///
    /// - Parameter animator: tranistionHandler
    /// - Returns: 自定义的动画
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        //避免手势与显示调用冲突，导致无法dismiss
        if !tranistionHandler.isInteraction {
            return nil
        }
        return tranistionHandler
    }
}
