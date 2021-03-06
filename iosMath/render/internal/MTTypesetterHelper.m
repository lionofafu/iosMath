//
//  MTTypesetterHelper.m
//  iosMath
//
//  Created by jiangxiaolong on 2017/6/19.
//
//

#import "MTTypesetterHelper.h"

#import "MTMathListDisplay.h"

@interface MTTypesetterHelper ()

@property (nonatomic, strong) NSMutableArray<MTCustomDisplay *> *customDisplays;

@end

@implementation MTTypesetterHelper

#pragma mark - Internal Method
+ (instancetype)shareHelper
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (void)initHelper
{
    MTTypesetterHelper *helper = (MTTypesetterHelper *)[self shareHelper];
    helper.customDisplays = nil;
}

+ (void)addCustomDisplay:(MTCustomDisplay *)display
{
    MTTypesetterHelper *helper = (MTTypesetterHelper *)[self shareHelper];
    if (!helper.customDisplays) {
        helper.customDisplays = [NSMutableArray array];
    }
    [helper.customDisplays addObject:display];
}

+ (NSArray<MTCustomDisplay *> *)currentCustomDisplays
{
    MTTypesetterHelper *helper = (MTTypesetterHelper *)[self shareHelper];
    return helper.customDisplays;
}

#pragma mark - TransformCustomDisplaysPosition
+ (void)transformCustomDisplaysPosition:(MTMathListDisplay *)displayList
{
    [self transformDisplaysList:displayList parentPosition:displayList.position];
}

CGPoint CGPointSumPoint(CGPoint pointA, CGPoint pointB)
{
    CGPoint sumPoint = CGPointMake(pointA.x + pointB.x, pointA.y + pointB.y);
    return sumPoint;
}

CGPoint CGPointAddOffsetY(CGPoint point, CGFloat offset)
{
    CGPoint sumPoint = CGPointMake(point.x, point.y + offset);
    return sumPoint;
}

+ (void)transformDisplaysList:(MTMathListDisplay *)displayList parentPosition:(CGPoint)parentPosition
{
    for (MTDisplay* display in displayList.subDisplays) {
        CGPoint newPosition = parentPosition;
        if ([display isKindOfClass:[MTFractionDisplay class]]) {
            MTFractionDisplay *fracDisplay = (MTFractionDisplay *)display;
            CGPoint numeratorPosition = CGPointSumPoint(newPosition, fracDisplay.numeratorOffset);
            [self transformDisplaysList:fracDisplay.numerator parentPosition:numeratorPosition];
            CGPoint denominatorPosition = CGPointSumPoint(newPosition, fracDisplay.denominatorOffset);
            [self transformDisplaysList:fracDisplay.denominator parentPosition:denominatorPosition];
        }else if ([display isKindOfClass:[MTRadicalDisplay class]]) {
            MTRadicalDisplay *radicalDisplay = (MTRadicalDisplay *)display;
            newPosition = CGPointSumPoint(newPosition, display.position);
            newPosition = CGPointSumPoint(newPosition, radicalDisplay.innerOffset);
            [self transformDisplaysList:radicalDisplay.radicand parentPosition:newPosition];
            [self transformDisplaysList:radicalDisplay.degree parentPosition:newPosition];
        }else if ([display isKindOfClass:[MTAccentDisplay class]]) {
            newPosition = CGPointSumPoint(newPosition, display.position);
            MTAccentDisplay *accentDisplay = (MTAccentDisplay *)display;
            [self transformDisplaysList:accentDisplay.accentee parentPosition:newPosition];
        }else if ([display isKindOfClass:[MTMathListDisplay class]]) {
            newPosition = CGPointSumPoint(newPosition, display.position);
            MTMathListDisplay *displayList = (MTMathListDisplay *)display;
            [self transformDisplaysList:displayList parentPosition:newPosition];
        }else if ([display isKindOfClass:[MTCustomDisplay class]]) {
            newPosition = CGPointSumPoint(newPosition, display.position);
            MTCustomDisplay *customDisplay = (MTCustomDisplay *)display;
            customDisplay.truePosition = newPosition;
            [self addCustomDisplay:customDisplay];
        }
    }
}

#pragma mark - Public
+ (NSArray<MTCustomDisplay *> *)collectCustomDisplaysWith:(MTMathListDisplay *)displayList
{
    [self initHelper];
    [self transformCustomDisplaysPosition:displayList];
    NSArray *result = [self currentCustomDisplays];
    return result;
}

@end
