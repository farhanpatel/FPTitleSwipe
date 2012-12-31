//
//  FPNavTitleSwipeView.m
//  PaigeeWorld
//
//  Created by Farhan Patel on 12-11-14.
//
//

#import "FPNavTitleSwipeView.h"
#import <QuartzCore/QuartzCore.h>

@interface FPNavTitleSwipeView ()

@property(strong)UIScrollView* scrollView;
@property(strong)NSArray* items;

-(void)scrollForward;
-(void)scrollBackward;

@end

@implementation FPNavTitleSwipeView
@synthesize scrollView,items,delegate,currentPage,currentPageColor,pageColor;

- (id)initWithFrame:(CGRect)frame titleItems:(NSArray*)titleItems
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setOpaque:NO];
        
        currentPage = 0;
        items = titleItems;
        
        //the default colors of the current page and selected page
        pageColor = [UIColor lightGrayColor];
        currentPageColor = [UIColor grayColor];
        
        scrollView = [[UIScrollView alloc] initWithFrame:frame];
        [scrollView setContentSize:CGSizeMake([items count]*CGRectGetWidth(frame),40)];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setDelegate:self];
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setBounces:NO];
        [scrollView setScrollEnabled:NO];
        
        
        for (int i = 0; i < [items count]; i++) {
            
            //customize the label. Set the text alignment, color and other title stuff.
            UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i*CGRectGetWidth(scrollView.frame), 0, 120, 40)];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
            [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
            [button.titleLabel setMinimumScaleFactor:3];
            [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [button setTitle:[titleItems objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(scrollForward) forControlEvents:UIControlEventTouchUpInside];
            
            //gesutres for the swiping left/right
            UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollForward)];
            swipe.direction = UISwipeGestureRecognizerDirectionLeft;
            [button addGestureRecognizer:swipe];
            
            UISwipeGestureRecognizer *leftswipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(scrollBackward)];
            leftswipe.direction = UISwipeGestureRecognizerDirectionRight;
            [button addGestureRecognizer:leftswipe];
    
            [scrollView addSubview:button];
        }
        
        [self addSubview:scrollView];
        [self setNeedsDisplay];
        
    }
    return self;
}






-(void)scrollForward {
    int nextPage =  (currentPage + 1) % [self.items count];
    
    if ([delegate respondsToSelector:@selector(titleViewChange:)]) {
        [delegate titleViewChange:nextPage];
    }
    
    CGFloat pageWidth = scrollView.bounds.size.width;
    currentPage = nextPage;
    [scrollView setContentOffset:CGPointMake(nextPage*pageWidth, 0) animated:YES];
    [self setNeedsDisplay];
}



-(void)scrollBackward {
    
    int nextPage =  (currentPage - 1);
    if (nextPage == -1) nextPage = [self.items count]-1;
    
    if ([delegate respondsToSelector:@selector(titleViewChange:)]) {
        [delegate titleViewChange:nextPage];
    }
    
    CGFloat pageWidth = scrollView.bounds.size.width;
    currentPage = nextPage;
    [scrollView setContentOffset:CGPointMake(nextPage*pageWidth, 0) animated:YES];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextSetAllowsAntialiasing(context, TRUE);
    

    CGFloat diameter = 4.0f;
    CGFloat space = 12.0f;
    CGFloat dotsWidth = [items count] * diameter + MAX(0, [self.items count] - 1) * space;
    CGFloat x = CGRectGetMidX(self.bounds) - dotsWidth / 2;
    CGFloat y = CGRectGetHeight( self.bounds)- diameter - 4;

	for (int i = 0 ; i < [self.items count] ; i++)
	{
		CGRect dotRect = CGRectMake(x, y, diameter, diameter) ;
		if (i == currentPage)
		{
            CGContextSetFillColorWithColor(context, currentPageColor.CGColor) ;
            CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f)) ;
		}
		else
		{
            CGContextSetFillColorWithColor(context, pageColor.CGColor) ;
            CGContextFillEllipseInRect(context, CGRectInset(dotRect, -0.5f, -0.5f)) ;
		}
		x += diameter + space;
	}
	
	CGContextRestoreGState(context);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, self.bounds);
}


@end
