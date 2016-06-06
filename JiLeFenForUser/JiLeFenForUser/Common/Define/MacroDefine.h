//
//  MacroDefine.h
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/2/21.
//  Copyright © 2016年 tarena. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kWindow [UIApplication sharedApplication].keyWindow

#define NAV_BAR_HEIGHT 44
#define NAV_BAR_FRAME (IOS7_OR_LATER? CGRectMake(0, 0, kScreenWidth, NAV_BAR_HEIGHT + STATUS_GAP):CGRectMake(0, 0, kScreenWidth, NAV_BAR_HEIGHT))

#define STATUS_GAP 20




#endif /* MacroDefine_h */
