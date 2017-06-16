//
//  MTCustomUtil.m
//  iosMath
//
//  Created by jiangxiaolong on 2017/6/14.
//
//

#import "MTCustomUtil.h"

@implementation MTCustomUtil

+ (NSString *)encodeString:(NSString *)string startString:(NSString *)startString endString:(NSString *)endString
{
    NSString *resultString = [string copy];
    resultString = [resultString stringByReplacingOccurrencesOfString:startString withString:CustomStartString()];
    resultString = [resultString stringByReplacingOccurrencesOfString:endString withString:CustomEndString()];
    
    return resultString;
}

+ (NSString *)decodeString:(NSString *)string startString:(NSString *)startString endString:(NSString *)endString
{
    NSString *resultString = [string copy];
    resultString = [resultString stringByReplacingOccurrencesOfString:CustomStartString() withString:startString];
    resultString = [resultString stringByReplacingOccurrencesOfString:CustomEndString() withString:endString];
    
    return resultString;
}

+ (NSString *)encodeCustomString:(NSString *)string
{
    return [self encodeString:string startString:[OriginStartString copy] endString:[OriginEndString copy]];
}

+ (NSString *)decodeCustomString:(NSString *)string
{
    return [self decodeString:string startString:[OriginStartString copy] endString:[OriginEndString copy]];
}

NSString *CustomStartString()
{
    static NSString *customStartString;
    if (!customStartString) {
        customStartString = [NSString stringWithFormat:@"%c", CustomStartChar];
    }
    return customStartString;
}

NSString *CustomEndString()
{
    static NSString *customEndString;
    if (!customEndString) {
        customEndString = [NSString stringWithFormat:@"%c", CustomEndChar];
    }
    return customEndString;
}

@end
