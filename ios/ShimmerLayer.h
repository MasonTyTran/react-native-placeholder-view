#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShimmerDirection) {
    ShimmerDirectionLeftToRight,
    ShimmerDirectionRightToLeft,
    ShimmerDirectionTopToBottom,
    ShimmerDirectionBottomToTop
};

@interface ShimmerLayer : CAGradientLayer

@property (nonatomic, strong) UIColor *shimmerColor;
@property (nonatomic, strong) UIColor *highlightColor;
@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic, assign) ShimmerDirection direction;

+ (instancetype)layer;
- (void)startShimmering;
- (void)stopShimmering;
- (void)updateDirection:(ShimmerDirection)direction;

@end
