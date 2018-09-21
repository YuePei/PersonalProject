//
//  SurroundPresentAnimation.m
//  FirstProject
//
//  Created by Peyton on 2018/8/14.
//  Copyright © 2018年 BJ. All rights reserved.
//

#import "SurroundPresentAnimation.h"
#import "SurroundMPVC.h"
#import "SDetailVc.h"
#import "GoodsCell.h"

@implementation SurroundPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    SurroundMPVC *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SDetailVc *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    CGRect rect1 = [transitionContext finalFrameForViewController:toVC];
    [toVC.view setFrame:rect1];
    
    GoodsCell *cell = (GoodsCell *)[fromVC.collectionView cellForItemAtIndexPath:[fromVC.collectionView indexPathsForSelectedItems].firstObject];
    UIView *snapView = [cell.bigIV snapshotViewAfterScreenUpdates:NO];
    CGRect snapRect = [fromVC.view convertRect:cell.bigIV.frame fromView:cell.bigIV.superview];
    
    snapRect = CGRectOffset(snapRect, 0, ysTopHeight);
    [snapView setFrame:snapRect];
    cell.bigIV.hidden = YES;
    
    toVC.bigImageView.hidden = YES;
    
    toVC.view.alpha = 0;
    [containView addSubview:toVC.view];
    [containView addSubview:snapView];
    
    CGRect snapFinalRect = CGRectMake(0, 0.5, SCREEN_WIDTH, SCREEN_WIDTH);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        [snapView setFrame:snapFinalRect];
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        toVC.bigImageView.hidden = NO;
        [snapView removeFromSuperview];
        cell.bigIV.hidden = NO;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end
