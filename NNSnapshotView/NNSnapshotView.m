//
//  NNSnapshotView.m
//  NNSnapshotViewDemo
//
//  Created by noughts on 2014/11/17.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "NNSnapshotView.h"

@implementation NNSnapshotView{
	__weak UIView* _targetView;
	CGRect _targetFrame;
	CADisplayLink* _displayLink;
	BOOL isCapturing;
}

-(instancetype)initWithTargetView:(UIView*)targetView targetFrame:(CGRect)targetFrame{
	CGRect rect = targetFrame;
	rect.origin = CGPointMake(0, 0);
	if( self = [super initWithFrame:rect] ){
		self.contentMode = UIViewContentModeTopLeft;
		_targetView = targetView;
		_targetFrame = targetFrame;
		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
	}
	return self;
}


-(void)willMoveToSuperview:(UIView *)newSuperview{
	if( !self.superview && newSuperview ){
		// mode を NSRunLoopCommonModes にすると、スクロール中でもCADisplayLinkが動作します。
		// http://stackoverflow.com/questions/12622800/why-does-uiscrollview-pause-my-cadisplaylink
		[_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	} else {
		[_displayLink invalidate];
	}
}



-(void)dealloc{
	
}



-(void)update:(CADisplayLink*)link{
	if( isCapturing ){
		return;
	}
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		isCapturing = YES;
		UIImage* img = [self screenCapture];
		dispatch_async(dispatch_get_main_queue(), ^{
			if( img ){
				self.image = img;
			}
			isCapturing = NO;
		});
	});
}


-(UIImage *)screenCapture {
	UIImage *capture;
	@try {
		UIGraphicsBeginImageContextWithOptions(_targetFrame.size, NO, [UIScreen mainScreen].scale);
		CGRect rect = _targetView.frame;
		rect.origin.x = 0 - _targetFrame.origin.x;
		rect.origin.y = 0 - _targetFrame.origin.y;
		[_targetView drawViewHierarchyInRect:rect afterScreenUpdates:NO];// afterScreenUpdatesをYESにするとglitchが発生するので注意
		capture = UIGraphicsGetImageFromCurrentImageContext();
	}
	@catch (NSException *exception) {
		NSLog( @"NNSnapshotView: %@", exception );
	}
	@finally {
		UIGraphicsEndImageContext();
	}
	return capture;
}








@end
