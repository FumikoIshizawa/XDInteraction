#import "WSUIButton.h"

@implementation WSUIButton

- (id)initWithFrame:(CGRect)frame
          withTitle:(NSString*)title {
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
  }
  
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  UIColor *outerTop = [UIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f];
  UIColor *shadowColor = [UIColor colorWithRed:0.1 green:0.1  blue:0.1 alpha:0.5];
  
  if (self.state != UIControlStateHighlighted) {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, outerTop.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
    CGContextAddArc(context,
                    rect.size.width / 2,
                    rect.size.height / 2,
                    rect.size.width / 2 - 5,
                    rect.size.height / 2 - 5,
                    360,
                    0);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
  }
}

@end
