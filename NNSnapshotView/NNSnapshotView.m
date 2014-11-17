//
//  NNSnapshotView.m
//  NNSnapshotViewDemo
//
//  Created by noughts on 2014/11/17.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "NNSnapshotView.h"

@implementation NNSnapshotView{
	UIView* _targetView;
	CGRect _targetFrame;
	UIView* _snapshot_view;
	CADisplayLink* _displayLink;
	BOOL isCapturing;
}

-(instancetype)initWithTargetView:(UIView*)targetView targetFrame:(CGRect)targetFrame{
	if( self = [super init] ){
		_targetView = targetView;
		_targetFrame = targetFrame;
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
		
		// mode を NSRunLoopCommonModes にすると、スクロール中でもCADisplayLinkが動作します。
		// http://stackoverflow.com/questions/12622800/why-does-uiscrollview-pause-my-cadisplaylink
		[_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	}
	return self;
}

-(void)dealloc{
	[_displayLink invalidate];
}



-(void)update:(CADisplayLink*)link{
	if( isCapturing ){
		return;
	}
	[_snapshot_view removeFromSuperview];
//	_snapshot_view = [_targetView resizableSnapshotViewFromRect:_targetFrame afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];// afterScreenUpdatesをYESにするとglitchが発生するので注意
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		isCapturing = YES;
		_snapshot_view = [_targetView snapshotViewAfterScreenUpdates:NO];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self addSubview:_snapshot_view];
			isCapturing = NO;
		});
	});
}


+ (UIImage *)screenCapture:(UIView *)view {
	UIImage *capture;
	UIGraphicsBeginImageContextWithOptions(view.frame.size , NO , 1.0 );
	[view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
	capture = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return capture;
}








@end
