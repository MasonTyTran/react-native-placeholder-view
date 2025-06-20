#import "ShimmerLayer.h"

@implementation ShimmerLayer

+ (instancetype)layer {
    ShimmerLayer *layer = [super layer];
    [layer setupDefaults];
    [layer applyDirection:layer.direction];
    [layer configureGradient];
    [layer startShimmering];
    return layer;
}

- (void)setupDefaults {
    self.masksToBounds = YES;
    self.shimmerColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    self.highlightColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    self.animationDuration = 1.2;
    self.direction = ShimmerDirectionLeftToRight;
}

- (void)configureGradient {
    if (!self.shimmerColor || !self.highlightColor) {
           return; // don't crash if not set yet
    }
    self.colors = @[
        (__bridge id)self.shimmerColor.CGColor,
        (__bridge id)self.highlightColor.CGColor,
        (__bridge id)self.shimmerColor.CGColor
    ];
    self.locations = @[@0, @0.5, @1];
    [self applyDirection:self.direction];
}

- (void)setShimmerColor:(UIColor *)shimmerColor {
    _shimmerColor = shimmerColor;
    [self configureGradient];
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    _highlightColor = highlightColor;
    [self configureGradient];
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    [self startShimmering];
}

- (void)startShimmering {
    [self removeAnimationForKey:@"shimmer"];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.fromValue = @[@-1, @-0.5, @0];
    animation.toValue = @[@1, @1.5, @2];
    animation.duration = self.animationDuration;
    animation.repeatCount = HUGE_VALF;

    [self addAnimation:animation forKey:@"shimmer"];
}

- (void)stopShimmering {
    [self removeAnimationForKey:@"shimmer"];
}

- (void)updateDirection:(ShimmerDirection)direction {
    self.direction = direction;
    [self applyDirection:direction];
}

- (void)applyDirection:(ShimmerDirection)direction {
    switch (direction) {
        case ShimmerDirectionLeftToRight:
            self.startPoint = CGPointMake(0, 0.5);
            self.endPoint = CGPointMake(1, 0.5);
            break;
        case ShimmerDirectionRightToLeft:
            self.startPoint = CGPointMake(1, 0.5);
            self.endPoint = CGPointMake(0, 0.5);
            break;
        case ShimmerDirectionTopToBottom:
            self.startPoint = CGPointMake(0.5, 0);
            self.endPoint = CGPointMake(0.5, 1);
            break;
        case ShimmerDirectionBottomToTop:
            self.startPoint = CGPointMake(0.5, 1);
            self.endPoint = CGPointMake(0.5, 0);
            break;
    }
}

@end
