//
//  CancelAttentionPopView.h
//  JiLeFenForUser
//
//  Created by huanghaiyang on 16/2/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  取消关注弹出框
 */
@interface CancelAttentionPopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
+ (instancetype)cancelAttentionPopView;
@end
