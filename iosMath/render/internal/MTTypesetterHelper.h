//
//  MTTypesetterHelper.h
//  iosMath
//
//  Created by jiangxiaolong on 2017/6/19.
//
//

#import <Foundation/Foundation.h>

@class MTCustomDisplay;
@class MTMathListDisplay;

@interface MTTypesetterHelper : NSObject

/** 遍历MTMathListDisplay的所有子display，发现MTCustomDisplay，并转换position为真实position
 */
+ (NSArray<MTCustomDisplay *> *)collectCustomDisplaysWith:(MTMathListDisplay *)displayList;

@end
