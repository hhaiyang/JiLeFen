//
//  NSString+Addition.m
//  FireflyFramework
//
//  Created by wenyanjie on 14-12-17.
//  Copyright (c) 2014年 wenyanjie. All rights reserved.
//

#import "NSString+Addition.h"
#import <CommonCrypto/CommonDigest.h>
#import "JPinYinUtil.h"

@implementation NSString (Addition)

+ (BOOL)strNilOrEmpty:(NSString *)aString
{
    if ([aString isKindOfClass:[NSString class]])
    {
        if (aString.length > 0)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}


- (BOOL)isEmptyWithTrim
{
    return [[self trim] isEqualToString:@""];
}


- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringMD5
{
    if(self == nil || [self length] == 0)
    {
        return nil;
    }
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)readSringWith:(NSString *)sourceString{
    NSString *replacedString = nil;
    NSInteger index = 0;
    for (int i=0; i<[sourceString length]; i++) {
        unichar character = [sourceString characterAtIndex:i];
        NSString *characterString = [NSString stringWithFormat:@"%C",character];
        const char *character_UTF8 = [characterString UTF8String];
        if (strlen(character_UTF8) == 3) {
            NSString *pingyin = [[self class] convertCharacter_CNToPinyin:character];
            if (pingyin != nil)
            {
                if (replacedString) {
                    NSRange characterRange = [replacedString rangeOfString:characterString options:NSCaseInsensitiveSearch range:NSMakeRange(index, replacedString.length - index)];
                    replacedString = [replacedString stringByReplacingCharactersInRange:characterRange withString:pingyin];
                    index = characterRange.location + pingyin.length;
                }else{
                    NSRange characterRange = [sourceString rangeOfString:characterString options:NSCaseInsensitiveSearch range:NSMakeRange(index, sourceString.length - index)];
                    replacedString = [sourceString stringByReplacingCharactersInRange:characterRange withString:pingyin];
                    index = i + pingyin.length;
                }
            }
            else
            {
//                return sourceString;
            }
        }
    }
    return replacedString;
}

+ (NSString *)convertCharacter_CNToPinyin:(unichar)charString{
    NSArray *pinyinArray = makePinYin2(charString);
    NSString *pinyinString = nil;
    if ([pinyinArray count]>0) {
        pinyinString = [NSString stringWithFormat:@"%@",[pinyinArray objectAtIndex:0]];
    }
    return pinyinString;
}

+ (NSString *)convertToPinyin:(NSString *)aString
{
    aString = [aString trim];
    if ([NSString strNilOrEmpty:aString])
    {
        return aString;
    }
    
    NSString *resultString = [[self class] readSringWith:aString];
    if ([NSString strNilOrEmpty:resultString])
    {
        return aString;
    }
    else
    {
        return resultString;
    }
}



@end
