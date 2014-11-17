//
//  ViewController.m
//  NNSnapshotViewDemo
//
//  Created by noughts on 2014/11/17.
//  Copyright (c) 2014年 noughts. All rights reserved.
//

#import "ViewController.h"
#import "NNSnapshotView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if( [segue.identifier isEqualToString:@"embed"] ){
		UIViewController* vc = segue.destinationViewController;
		NNSnapshotView* snapshot = [[NNSnapshotView alloc] initWithTargetView:vc.view targetFrame:CGRectMake(0, 0, 320, 200)];
		snapshot.center = CGPointMake(10, 10);
		[self.view addSubview:snapshot];
		
//		NNSnapshotView* snapshot2 = [[NNSnapshotView alloc] initWithTargetView:vc.view targetFrame:CGRectMake(0, 100, 320, 200)];
//		snapshot2.center = CGPointMake(-10, 100);
//		[self.view addSubview:snapshot2];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
