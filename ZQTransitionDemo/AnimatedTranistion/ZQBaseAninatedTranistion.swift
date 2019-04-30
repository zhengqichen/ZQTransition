//
//  ZQBaseAninatedTranistion.swift
//  ZQTransitionDemo
//
//  Created by 雷丹 on 2019/4/30.
//  Copyright © 2019 CZQ. All rights reserved.
//

import UIKit

class ZQBaseAninatedTranistion: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    
    /**动画时长*/
    var animateDuration:TimeInterval = 0.5
    /**判断是否已经弹出*/
    var isPopup:Bool = false
    /**交互状态*/
    var isInteraction:Bool = false
    /**转场上下文*/
    var context:UIViewControllerContextTransitioning?
    /**视图*/
    var containerView:UIView?
    /**当前view*/
    var fromView:UIView?
    /**目标view*/
    var toView:UIView?
    /**当前控制器*/
    var fromViewController:UIViewController?
    /**目标控制器*/
    var toViewController:UIViewController?
    
    /// 设置动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        context = transitionContext
        return animateDuration
    }
    
    /// 执行动画过程
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        context = transitionContext
        //容器
        containerView = transitionContext.containerView
        //目标控制器
        fromViewController = transitionContext.viewController(forKey: .from)
        toViewController = transitionContext.viewController(forKey: .to)
        fromView = fromViewController?.view
        toView = toViewController?.view
        isPopup ? dismiss():present()
    }
    
    /// 弹出
    func present(){
        //子类需要重写
    }
    
    func dismiss(){
        //子类需要重写
    }
    
}
