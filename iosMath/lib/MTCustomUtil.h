//
//  MTCustomUtil.h
//  iosMath
//
//  Created by jiangxiaolong on 2017/6/14.
//
//

#import <Foundation/Foundation.h>

static const char CustomStartChar = 0x1e;//\u00c1
static const char CustomEndChar = 0x1f;//\u00c2

static const NSString *OriginStartString = @"${";
static const NSString *OriginEndString = @"}$";

@interface MTCustomUtil : NSObject

/** 转换起止字符串为单一起止字符，返回的LaTex中CustomString由\u0002和\u0003起止
 */
+ (NSString *)encodeString:(NSString *)string startString:(NSString *)startString endString:(NSString *)endString;

/** 转换单一起止字符为起止字符串，返回的LaTex中CustomString由startString和endString起止
 */
+ (NSString *)decodeString:(NSString *)string startString:(NSString *)startString endString:(NSString *)endString;

+ (NSString *)encodeCustomString:(NSString *)string;
+ (NSString *)decodeCustomString:(NSString *)string;

NSString *CustomStartString();
NSString *CustomEndString();

@end
