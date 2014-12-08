//
//  TagList.m
//  ios_tag_list
//
//  Created by Maxim on 9/23/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import "TagList.h"
#import "TagView.h"
#import "UIColor+TagColors.h"

#define TAG_LIST_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(code)           \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
code;                                                                   \
_Pragma("clang diagnostic pop")                                         \

static const CGFloat TagListElementWidth			= 88;
static const CGFloat TagListElementHeight			= 30;
static const CGFloat TagListElementSpacingX			= 9;
static const CGFloat TagListElementSpacingY			= 10;

static const NSInteger TagListMaxTagsInRow			= 3;

static const CGFloat TagListDefaultHighlightAlpha	= 0.7f;

@interface TagList ()
{
    CGFloat posX;
    CGFloat	posY;
    
    SEL touchTagSelector;
    SEL touchBackgroundSelector;
}

- (void)touchTag:(id)sender;

@end

@implementation TagList

@synthesize tagDelegate = _tagDelegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		posX = frame.origin.x;
		posY = frame.origin.y;
        self.maxTagsInRow = TagListMaxTagsInRow;
        self.elementWidth = TagListElementWidth;
        self.elementHeight = TagListElementHeight;
        self.elementSpacingX = TagListElementSpacingX;
        self.elementSpacingY = TagListElementSpacingY;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    posX = self.frame.origin.x;
    posY = self.frame.origin.y;
}

- (instancetype)init
{
	self = [self initWithFrame:CGRectMake(0, 0, 0, 0)];
	
	return self;
}

- (instancetype)initWithX:(CGFloat)x withY:(CGFloat)y
{
	self = [self initWithFrame:CGRectMake(x, y, 0, 0)];

	return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    posX = self.frame.origin.x;
    posY = self.frame.origin.y;
    self.maxTagsInRow = TagListMaxTagsInRow;
    self.elementWidth = TagListElementWidth;
    self.elementHeight = TagListElementHeight;
    self.elementSpacingX = TagListElementSpacingX;
    self.elementSpacingY = TagListElementSpacingY;
}

- (void)setPosX:(CGFloat)x andY:(CGFloat)y
{
    posX = x;
    posY = y;
}

- (void)createTags:(NSArray *)texts
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
	NSInteger rowCount = ceil(texts.count / (float)self.maxTagsInRow);
	CGFloat width = texts.count * self.elementWidth + (texts.count - 1) * self.elementSpacingX;
	CGFloat height = rowCount * self.elementHeight + (rowCount - 1) * self.elementSpacingY;
	
	self.frame = CGRectMake(posX, posY, width, height);
	
	CGFloat x = 0;
	CGFloat y = 0;
	
	NSInteger index = 0;
	NSInteger rowIndex = 0;
	
	for (NSString *str in texts) {
		TagView* tagView = [[TagView alloc] initWithFrame:CGRectMake(x, y, self.elementWidth, self.elementHeight)];
		[tagView setText:str];
		[self addSubview:tagView];
		
        tagView.fontName = self.fontName;
        tagView.fontSize = self.fontSize;
        tagView.fontSizeMin = self.fontSizeMin;
        
		UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTag:)];
        [tagView setUserInteractionEnabled:YES];
        [tagView addGestureRecognizer:gesture];
	
		switch (index) {
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
		x += self.elementWidth + self.elementSpacingX;
		if (rowIndex == self.maxTagsInRow) {
			x = 0;
			rowIndex = 0;
			y += self.elementHeight + self.elementSpacingY;
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
 	
	if(tagView && self.tagDelegate && [self.tagDelegate respondsToSelector:touchTagSelector]) {
		TAG_LIST_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.tagDelegate performSelector:touchTagSelector withObject:tagView.text];)
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (self.tagDelegate && [self.tagDelegate respondsToSelector:touchBackgroundSelector]) {
		TAG_LIST_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.tagDelegate performSelector:touchBackgroundSelector];)
	}
}

@end
