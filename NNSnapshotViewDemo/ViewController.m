//
//  ViewController.m
//  NNSnapshotViewDemo
//
//  Created by noughts on 2014/11/17.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "ViewController.h"
#import "NNSnapshotView.h"


@implementation ViewController{
	NNSnapshotView* _snapshot_view;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if( [segue.identifier isEqualToString:@"embed"] ){
		UIViewController* vc = segue.destinationViewController;
		_snapshot_view = [[NNSnapshotView alloc] initWithTargetView:vc.view targetFrame:CGRectMake(0, 400, 300, 200)];
		[self.view addSubview:_snapshot_view];
		
//		NNSnapshotView* snapshot2 = [[NNSnapshotView alloc] initWithTargetView:vc.view targetFrame:CGRectMake(0, 100, 320, 200)];
//		snapshot2.center = CGPointMake(200, 200);
//		[self.view addSubview:snapshot2];
	}
}



-(IBAction)onRemoteButtonTap:(id)sender{
	[_snapshot_view removeFromSuperview];
	_snapshot_view = nil;
}




- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
