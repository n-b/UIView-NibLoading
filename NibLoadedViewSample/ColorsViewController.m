//
//  ColorsViewController.m
//  NibLoadedViewSample
//
//  Created by Nicolas on 24/01/13.
//  Copyright (c) 2013 Nicolas Bouilleaud. All rights reserved.
//

#import "ColorsViewController.h"
#import "ColorView.h"

@implementation ColorsViewController
{
    IBOutlet ColorView * _colorView1;
    ColorView * _colorView2;
    ColorView * _colorView3;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    // _colorView1 is loaded from nib
    _colorView1.color = [UIColor colorWithRed:.3 green:.5 blue:.7 alpha:1.0];

    // _colorView2 is created in code with a specific size
    _colorView2 = [[ColorView alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    [self.view addSubview:_colorView2];
    _colorView2.backgroundColor = [UIColor darkGrayColor];
    _colorView2.color = [UIColor colorWithRed:.7 green:.3 blue:.5 alpha:1.0];

    // _colorView3 is created in code, and uses the default size
    _colorView3 = [[ColorView alloc] init];
    [self.view addSubview:_colorView3];
    _colorView3.frame = CGRectOffset(_colorView1.frame, 0, CGRectGetMaxY(_colorView2.frame));
    _colorView3.backgroundColor = [UIColor whiteColor];
    _colorView3.color = [UIColor colorWithRed:.5 green:.7 blue:.3 alpha:1.0];
}

@end
