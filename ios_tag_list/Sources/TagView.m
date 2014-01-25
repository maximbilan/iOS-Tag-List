//
//  TagView.m
//  wymg
//
//  Created by Maxim on 9/22/13.
//  Copyright (c) 2013 Maxim. All rights reserved.
//

#import "TagView.h"
#import "UIColor+TagColors.h"

#import <CoreText/CoreText.h>

static const	CGFloat				TagViewHighlightAlpha	= 0.5f;
static			NSString * const	TagViewFontFamily		= @"HelveticaNeue-Light";
static const	CGFloat				TagViewFontSize			= 12.0f;
static const	CGFloat				TagViewFontSizeMin		= 10.0f;
static const	int					TagViewMaxCharacter		= 10;

@implementation TagView

@synthesize color = _color;
@synthesize colorHightlighted = _colorHightlighted;
@synthesize fontColor = _fontColor;
@synthesize text = _text;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
	{
		state = TagViewStateNormal;
		
		_color = [UIColor yellowTagColor];
		_colorHightlighted = [UIColor yellowTagColor:TagViewHighlightAlpha];
		_fontColor = [UIColor colorWithRed:0.298 green:0.337 blue:0.424 alpha:1.000];
		_text = @"Default";
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect( context, rect );
	
	const BOOL reduce = ( _text.length > TagViewMaxCharacter );
	UIColor *color = nil;
	
	switch ( state )
	{
		case TagViewStateNormal:
		{
			color = _color;
		}
		break;
		
		case TagViewStateHighlighted:
		{
			color = _colorHightlighted;
		}
		break;
			
		default:
			break;
	}
	
	CGContextSetFillColorWithColor( context, [UIColor whiteColor].CGColor );
	CGContextFillRect( context, rect );
	
    CGContextSetFillColorWithColor( context, color.CGColor );
    CGMutablePathRef roundedRectPath = CGPathCreateMutable();
	CGPathAddRoundedRect( roundedRectPath, NULL, CGRectMake( 0, 0, rect.size.width, rect.size.height ), 5.0f, 5.0f );
    CGContextAddPath( context, roundedRectPath );
    CGContextFillPath( context );
    
	CTFontRef font = CTFontCreateWithName( (CFStringRef)TagViewFontFamily, ( reduce ? TagViewFontSizeMin : TagViewFontSize ), NULL );
	CGColorRef fontColorRef = _fontColor.CGColor;
	
	NSString *finalText = ( !reduce ? _text : [NSString stringWithFormat:@"%@...", [_text substringToIndex:TagViewMaxCharacter]] );
	
	CGContextSetTextMatrix( context, CGAffineTransformIdentity );
	CGContextTranslateCTM( context, 0, rect.size.height );
	CGContextScaleCTM( context, 1.0, -1.0 );
	
	CTTextAlignment alignment = kCTTextAlignmentCenter;
	
	CTParagraphStyleSetting settings[] = {
		{ kCTParagraphStyleSpecifierAlignment, sizeof( alignment ), &alignment }
	};
	
	CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate( settings, sizeof( settings ) / sizeof( settings[0] ) );
	
	CFStringRef keys[] = { kCTFontAttributeName , kCTParagraphStyleAttributeName, kCTForegroundColorAttributeName };
	CFTypeRef values[] = { font, paragraphStyle, fontColorRef };
	CFDictionaryRef attr = CFDictionaryCreate( NULL, (const void **)&keys, (const void **)&values, sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks,
											  &kCFTypeDictionaryValueCallBacks);
	CFAttributedStringRef attrString = CFAttributedStringCreate( NULL, (CFStringRef)finalText, attr );
	
	CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFAttributedStringRef)attrString );
	
	CGRect boundingBox = CTFontGetBoundingBox( font );
	
	const float midHeight = rect.size.height * 0.5f;
	const float midFontBBHeight = boundingBox.size.height * 0.5f;
	const float height = midHeight + midFontBBHeight;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect( path, NULL, CGRectMake( 0, 0, rect.size.width, height ) );
    
	CTFrameRef frame = CTFramesetterCreateFrame( framesetter, CFRangeMake( 0, 0 ), path, NULL );
	CTFrameDraw( frame, context );
    
    CFRelease( attrString );
    CGPathRelease( roundedRectPath );
    CGPathRelease( path );
    CFRelease( framesetter );
    CFRelease( frame );
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	state = TagViewStateHighlighted;
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	state = TagViewStateNormal;
	[self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	state = TagViewStateNormal;
	[self setNeedsDisplay];
}

@end
