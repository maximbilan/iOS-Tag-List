//
//  TagList.m
//  wymg
//
//  Created by Maxim on 9/23/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import "TagList.h"
#import "TagView.h"
#import "UIColor+TagColors.h"

#import "../../Common/Defines.h"

static const CGFloat TagListElementWidth			= 88;
static const CGFloat TagListElementHeight			= 30;
static const CGFloat TagListElementSpacingX			= 9;
static const CGFloat TagListElementSpacingY			= 10;

static const NSInteger TagListMaxTagsInRow			= 3;

static const CGFloat TagListDefaultHighlightAlpha	= 0.7f;

@interface TagList ()

- (void)touchTag:(id)sender;

@end

@implementation TagList

@synthesize tagDelegate = _tagDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
	{
		posX = frame.origin.x;
		posY = frame.origin.y;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    posX = self.frame.origin.x;
    posY = self.frame.origin.y;
}

- (id)init
{
	self = [self initWithFrame:CGRectMake( 0, 0, 0, 0 )];
	
	return self;
}

- (id)init:(CGFloat)x posY:(CGFloat)y
{
	self = [self initWithFrame:CGRectMake( x, y, 0, 0 )];

	return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    posX = self.frame.origin.x;
    posY = self.frame.origin.y;
}

- (void)setPosX:(CGFloat)x andY:(CGFloat)y
{
    posX = x;
    posY = y;
}

- (void)createTags:(NSArray *)texts
{
	for( TagView *tv in tags )
	{
		[tv removeFromSuperview];
	}
	[tags removeAllObjects];
	
	NSInteger rowCount = ceil( texts.count / (float)TagListMaxTagsInRow );
	CGFloat width = texts.count * TagListElementWidth + ( texts.count - 1 ) * TagListElementSpacingX;
	CGFloat height = rowCount * TagListElementHeight + ( rowCount - 1 ) * TagListElementSpacingY;
	
	self.frame = CGRectMake( posX, posY, width, height );
	
	CGFloat x = 0;
	CGFloat y = 0;
	
	NSInteger index = 0;
	NSInteger rowIndex = 0;
	
	for( NSString *str in texts )
	{
		TagView* tagView = [[TagView alloc] initWithFrame:CGRectMake( x, y, TagListElementWidth, TagListElementHeight ) ];
		[tagView setText:str];
		[self addSubview:tagView];
		[tags addObject:tagView];
		
		UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTag:)];
        [tagView setUserInteractionEnabled:YES];
        [tagView addGestureRecognizer:gesture];
	
		switch( index )
		{
			case 0:
			case 1:
            case 2:
			{
				[tagView setColor:[UIColor yellowTagColor]];
				[tagView setColorHightlighted:[UIColor yellowTagColor:TagListDefaultHighlightAlpha]];
			}
			break;
				
			case 3:
			case 4:
            case 5:
			{
				[tagView setColor:[UIColor redTagColor]];
				[tagView setColorHightlighted:[UIColor redTagColor:TagListDefaultHighlightAlpha]];
			}
			break;
				
			default:
			{
				[tagView setColor:[UIColor greenTagColor]];
				[tagView setColorHightlighted:[UIColor greenTagColor:TagListDefaultHighlightAlpha]];
			}
			break;
		}
		
		++index;
		++rowIndex;
		x += TagListElementWidth + TagListElementSpacingX;
		if( rowIndex == TagListMaxTagsInRow )
		{
			x = 0;
			rowIndex = 0;
			y += TagListElementHeight + TagListElementSpacingY;
		}
	}
}

- (void)setTouchTagSelector:(SEL)selector
{
	touchTagSelector = selector;
}

- (void)setTouchBackgroundSelector:(SEL)selector
{
	touchBackgroundSelector = selector;
}

- (void)touchTag:(id)sender
{
	UITapGestureRecognizer *t = (UITapGestureRecognizer *)sender;
    TagView *tagView = (TagView *)t.view;
 	
	if( tagView && self.tagDelegate && [self.tagDelegate respondsToSelector:touchTagSelector] )
	{
		SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( [self.tagDelegate performSelector:touchTagSelector withObject:tagView.text]; )
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if( self.tagDelegate && [self.tagDelegate respondsToSelector:touchBackgroundSelector] )
	{
		SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING( [self.tagDelegate performSelector:touchBackgroundSelector]; )
	}
}

@end
