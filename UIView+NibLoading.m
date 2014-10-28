//
//  UIView+NibLoading.m
//
//  Created by Nicolas Bouilleaud.
//
// 	https://github.com/n-b/UIView-NibLoading

#import "UIView+NibLoading.h"
#import <objc/runtime.h>

@implementation UIView(NibLoading)

+ (UINib*) _nibLoadingAssociatedNibWithName:(NSString*)nibName
{
    static char kUIViewNibLoading_associatedNibsKey;

    NSDictionary * associatedNibs = objc_getAssociatedObject(self, &kUIViewNibLoading_associatedNibsKey);
    UINib * nib = associatedNibs[nibName];
    if(nil==nib)
    {
        nib = [UINib nibWithNibName:nibName bundle:[NSBundle bundleForClass:self]];
        if(nib)
        {
            NSMutableDictionary * newNibs = [NSMutableDictionary dictionaryWithDictionary:associatedNibs];
            newNibs[nibName] = nib;
            objc_setAssociatedObject(self, &kUIViewNibLoading_associatedNibsKey, [NSDictionary dictionaryWithDictionary:newNibs], OBJC_ASSOCIATION_RETAIN);
        }
    }

    return nib;
}

static char kUIViewNibLoading_outletsKey;

- (void) loadContentsFromNibNamed:(NSString*)nibName
{
    // Load the nib file, setting self as the owner.
    // The root view is only a container and is discarded after loading.
    UINib * nib = [[self class] _nibLoadingAssociatedNibWithName:nibName];
    NSAssert(nib!=nil, @"UIView+NibLoading : Can't load nib named %@.",nibName);

    // Instantiate (and keep a list of the outlets set through KVC.)
    NSMutableDictionary * outlets = [NSMutableDictionary new];
    objc_setAssociatedObject(self, &kUIViewNibLoading_outletsKey, outlets, OBJC_ASSOCIATION_RETAIN);
    NSArray * views = [nib instantiateWithOwner:self options:nil];
    NSAssert(views!=nil, @"UIView+NibLoading : Can't instantiate nib named %@.",nibName);
    objc_setAssociatedObject(self, &kUIViewNibLoading_outletsKey, nil, OBJC_ASSOCIATION_RETAIN);

    // Search for the first encountered UIView base object
    UIView * containerView = nil;
    for (id v in views)
    {
        if ([v isKindOfClass:[UIView class]])
        {
            containerView = v;
            break;
        }
    }
    NSAssert(containerView!=nil, @"UIView+NibLoading : There is no container UIView found at the root of nib %@.",nibName);
    
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    if(CGRectEqualToRect(self.bounds, CGRectZero))
    {
        // `self` has no size : use the containerView's size, from the nib file
        self.bounds = containerView.bounds;
    }
    else
    {
        // `self` has a specific size : resize the containerView to this size, so that the subviews are autoresized.
        containerView.bounds = self.bounds;
    }
    
    // Save constraints for later
    NSArray * constraints = containerView.constraints;
    
    // reparent the subviews from the nib file
    for (UIView * view in containerView.subviews)
    {
        [self addSubview:view];
    }
    
    // Recreate constraints, replace containerView with self
    for (NSLayoutConstraint *oldConstraint in constraints)
    {
        id firstItem = oldConstraint.firstItem;
        id secondItem = oldConstraint.secondItem;
        if (firstItem == containerView)
        {
            firstItem = self;
        }
        if (secondItem == containerView)
        {
            secondItem = self;
        }
        
        NSLayoutConstraint * newConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                          attribute:oldConstraint.firstAttribute
                                                                          relatedBy:oldConstraint.relation
                                                                             toItem:secondItem
                                                                          attribute:oldConstraint.secondAttribute
                                                                         multiplier:oldConstraint.multiplier
                                                                           constant:oldConstraint.constant];
        [self addConstraint:newConstraint];
        
        // If there was outlet(s) to the old constraint, replace it with the new constraint.
        for (NSString * key in outlets)
        {
            if (outlets[key]==oldConstraint)
            {
                NSAssert([self valueForKey:key]==oldConstraint, @"UIView+NibLoading : Unexpected value for outlet %@ of view %@. Expected %@, found %@.", key, self, oldConstraint, [self valueForKey:key]);
                [self setValue:newConstraint forKey:key];
            }
        }
    }
}

- (void) setValue:(id)value forKey:(NSString *)key
{
    // Keep a list of the outlets set during nib loading.
    // (See above: This associated object only exists during nib-loading)
    NSMutableDictionary * outlets = objc_getAssociatedObject(self, &kUIViewNibLoading_outletsKey);
    outlets[key] = value;
    [super setValue:value forKey:key];
}

- (void) loadContentsFromNib
{
    NSString *className = NSStringFromClass([self class]);
    // A Swift class name will be in the format of ModuleName.ClassName
    // We want to remove the module name so the Nib can have exactly the same file name as the class
    NSRange range = [className rangeOfString:@"."];
    if (range.location != NSNotFound)
    {
        className = [className substringFromIndex:range.location + range.length];
    }
    [self loadContentsFromNibNamed:className];
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
