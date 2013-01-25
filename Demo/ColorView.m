//
//  ColorView.m
//  NibLoadedViewSample
//
//  Created by Nicolas Bouilleaud.
//
// 	https://github.com/n-b/UIView-NibLoading

#import "ColorView.h"

@implementation ColorView
{
    IBOutlet UILabel * _codeLabel;
    IBOutlet UIView * _swatch;
}

- (void)setColor:(UIColor *)color_
{
    _color = color_;
    
    _swatch.backgroundColor = color_;

    CGFloat red, green, blue, alpha;
    [_color getRed:&red green:&green blue:&blue alpha:&alpha];
    _codeLabel.text = [NSString stringWithFormat:@"#%2X%2X%2X",(int)(red*0xFF), (int)(green*0xFF), (int)(blue*0xFF)];
}

@end
