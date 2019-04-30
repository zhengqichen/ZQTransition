//
//  ZQFullCoverAnimatedTranistion.swift
//  ZQTransitionDemo
//
//  Created by 雷丹 on 2019/4/30.
//  Copyright © 2019 CZQ. All rights reserved.
//

import UIKit


class ZQFullCoverAnimatedTranistion: ZQBaseAninatedTranistion {
    //最大偏移位置
    var maxOffset:CGFloat = 0.0
    //最右临界值
    var rightCritcal:CGFloat = 20.0
    //手势
    var leftPanGesture:UIScreenEdgePanGestureRecognizer?
    
    /// 启用边缘滑动返回
    func usingLeftSwipDismiss(view:UIView){
        //监听边缘滑动
        leftPanGesture  = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.onEdgeSlide))
        //左侧边缘滑动
        leftPanGesture!.edges = .left
        //添加事件
        view.addGestureRecognizer(leftPanGesture!)
    }
    
    /// 当边缘滑动
    @objc func onEdgeSlide(reco:UIScreenEdgePanGestureRecognizer){
        let point = reco.location(in: reco.view)
        //执行动画转场
        let progress = point.x / reco.view!.bounds.width
        if reco.state == .began {
            //变更状态
            isInteraction = true
            //当开始，复位
            maxOffset = 0.0
            //---------这行很关键-----------
            fromViewController?.dismiss(animated: true, completion: nil)
        } else if reco.state == .changed {
            maxOffset = max(point.x, maxOffset)
            update(progress)
        } else {
            //当结束后
            if point.x >= maxOffset && point.x > rightCritcal {
                //完成退出
                finish()
            }else {
                //取消后恢复
                cancel()
            }
            //变更状态
            isInteraction = false
        }
    }
    
    /// 弹出动画，你可以在这这个方法里面实现你想要的任意动画
    override func present(){
        //目标视图
        let toFrame = context!.finalFrame(for: toViewController!)
        //添加视图
        containerView!.addSubview(toView!)
        let rect = containerView!.bounds
        //设置动画
        toView!.frame = CGRect(x: 0, y: rect.height * 2, width: rect.width, height: rect.height)
        UIView.animate(withDuration: animateDuration, animations: { [weak self] in
            self!.toView!.frame.origin.y = 0
            self!.fromView!.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {[weak self] (r) in
            if self!.context!.transitionWasCancelled {
                //操作失败了
                self!.context!.completeTransition(false)
                //移除视图
                self!.toView?.removeFromSuperview()
            }else{
                self!.isPopup = true
                self!.toView?.frame = toFrame
                self!.context!.completeTransition(true)
            }
        }
    }
    
    
    /// 弹回动画，你可以在这这个方法里面实现你想要的任意动画
    override func dismiss(){
        //添加toView到底部一层
        containerView!.addSubview(toView!)
        containerView!.sendSubviewToBack(toView!)
        //添加视图
        let rect = containerView!.bounds
        //设置动画
        UIView.animate(withDuration: animateDuration, animations: { [weak self] in
            self!.fromView?.frame.origin.y = rect.height * 2
            self!.toView?.transform = .identity
        }) { [weak self] (r) in
            //取消
            if self!.context!.transitionWasCancelled {
                //操作失败
                self!.context?.completeTransition(false)
                self!.toView?.removeFromSuperview()
            }else{
                self!.isPopup = false
                //将原始视图移除
                self!.fromView?.removeFromSuperview()
                //通知系统是否被取消，用于记录动画是否完成
                self!.context!.completeTransition(true)
                //移除手势
                if self!.leftPanGesture != nil && self!.fromView != nil{
                    self!.fromView?.removeGestureRecognizer(self!.leftPanGesture!)
                }
            }
        }
    }
    
}
