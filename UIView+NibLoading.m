//
//  UIView+NibLoading.m
//
//  Created by Nicolas Bouilleaud.
//
// 	https://github.com/n-b/UIView-NibLoading

#import "UIView+NibLoading.h"

@implementation UIView(NibLoading)

- (void) loadContentsFromNibNamed:(NSString*)nibName
{
    // Load the nib file, setting self as the owner.
    // The root view is only a container and is discarded after loading.
    NSArray * views = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    NSAssert(views!=nil, @"UIView+NibLoading : Can't load nib named %@.",nibName);
    NSAssert(views.count==1, @"UIView+NibLoading : There must be exactly one root container view in %@.",nibName);
    UIView * containerView = [views objectAtIndex:0];
    NSAssert([[containerView class] isEqual:[UIView class]], @"UIView+NibLoading : The container view in nib %@ should be a UIView instead of %@. (It's only a container, and it's discarded after loading.)",nibName,[containerView class]);
    
    if(CGRectEqualToRect(self.bounds, CGRectZero))
        // `self` has no size : use the containerView's size, from the nib file
        self.bounds = containerView.bounds;
    else
        // `self` has a specific size : resize the containerView to this size, so that the subviews are autoresized.
        containerView.bounds = self.bounds;
    
    // reparent the subviews from the nib file
    for (UIView * view in containerView.subviews)
        [self addSubview:view];
}

- (void) loadContentsFromNib
{
    [self loadContentsFromNibNamed:NSStringFromClass([self class])];
}

@end

#pragma mark NibLoadedView

@implementation NibLoadedView : UIView

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self loadContentsFromNib];
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self loadContentsFromNib];
    return self;
}

@end
