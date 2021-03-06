//
//  AccountValidate.m
//  Elearning
//
//  Created by huanghaiyang on 16/4/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "AccountValidate.h"

@implementation AccountValidate
//验证邮箱
+ (BOOL)validateEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//验证手机号
+ (BOOL)validatePhone:(NSString*)phone
{
    /**
     *手机号码
     *移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     *联通：130,131,132,152,155,156,185,186
     *电信：133,1349,153,180,189
     */
    NSString *MOBILE=@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10    *中国移动：ChinaMobile
     11    *134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12    */
    NSString *CM=@"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15    *中国联通：ChinaUnicom
     16    *130,131,132,152,155,156,185,186
     17    */
    NSString *CU=@"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20    *中国电信：ChinaTelecom
     21    *133,1349,153,180,189
     22    */
    NSString*CT=@"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25    *大陆地区固话及小灵通
     26    *区号：010,020,021,022,023,024,025,027,028,029
     27    *号码：七位或八位
     28    */
    //NSString*PHS=@"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",CT];
    if(([regextestmobile evaluateWithObject:phone] == YES) || ([regextestcm evaluateWithObject:phone] == YES) || ([regextestct evaluateWithObject:phone] == YES) || ([regextestcu evaluateWithObject:phone] == YES))
    {
        return YES;
    }
    return NO;
}

@end
