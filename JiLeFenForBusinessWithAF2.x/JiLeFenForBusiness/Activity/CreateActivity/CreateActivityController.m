//
//  CreateActivityController.m
//  JiLeFenForBusiness
//
//  Created by huanghaiyang on 16/5/22.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CreateActivityController.h"
#import "ActivityTitleView.h"
#import "ActivityDateView.h"
#import "SelectImageView.h"
#import "ActivityContentView.h"
#import "ActivityPopView.h"

@interface CreateActivityController () <ActivityTitleViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate, ActivityPopViewDelegate>
@property (nonatomic, strong) UIImagePickerController *titleImagePickerController;
@property (nonatomic, strong) UIImagePickerController *contentImagePickerController;
@property (nonatomic, strong) UIImagePickerController *takePhotoImagePickerController;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) ActivityTitleView *titleView;
@property (nonatomic, strong) ActivityDateView *dateView;
@property (nonatomic, strong) ActivityContentView *activityContentView;
@property (nonatomic, strong) ActivityPopView *popView;
@property (nonatomic, assign) CGRect keyboardFrame;
@property (nonatomic, assign) NSTimeInterval keyboardAnimationDuration;
@property (nonatomic, assign) UIViewAnimationOptions keyboardAnimationOption;
@end

@implementation CreateActivityController
- (ActivityPopView *)popView {
    if (_popView) {
        return _popView;
    }
    _popView = [ActivityPopView new];
    _popView.delegate = self;
    return _popView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布活动";
    [self initNavi];
    [self setupSubviews];
    [self addKeyboardNotification];
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)noti {
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.keyboardAnimationDuration = duration;
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    self.keyboardAnimationOption = option;
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardFrame = keyboardFrame;
    if (![self.activityContentView.contentTextView isFirstResponder]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        return;
    }
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    TEST_LOG(@"noti = %@", noti);
    __weak typeof(self) weakSelf = self;
    CGRect contentViewFrame = self.contentView.frame;
    contentViewFrame.origin.y = 64;
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        weakSelf.contentView.frame = contentViewFrame;
    } completion:nil];
   
    
    
}
- (void)initNavi {
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(createAction)];
    self.navigationItem.rightBarButtonItem = createItem;
}

- (void)setupSubviews {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    self.contentView = contentView;
    contentView.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
    [self.view addSubview:contentView];
    
    ActivityTitleView *titleView = [[ActivityTitleView alloc] initWithFrame:CGRectMake(0, 0, contentView.width, 50)];
    titleView.delegate = self;
    self.titleView = titleView;
    [contentView addSubview:titleView];
    
    ActivityDateView *dateView = [[ActivityDateView alloc] initWithFrame:CGRectMake(0, titleView.y+titleView.height, contentView.width, 50)];
    self.dateView = dateView;
    [contentView addSubview:dateView];
    
    SelectImageView *selectImageView = [[SelectImageView alloc] initWithFrame:CGRectMake(0, contentView.height-50, contentView.width, 50)];
    [selectImageView.selectImageButton addTarget:self action:@selector(selectImageAction) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:selectImageView];
    
    ActivityContentView *activityContentView = [[ActivityContentView alloc] initWithFrame:CGRectMake(0, dateView.y+dateView.height, contentView.width, contentView.height-titleView.height-dateView.height-selectImageView.height)];
    activityContentView.contentTextView.delegate = self;
    self.activityContentView = activityContentView;
    [contentView addSubview:activityContentView];
    
}
- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createAction {
    MBProgressHUD *hud = nil;
    if (self.titleView.titleTextField.text.length <= 0) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入活动标题";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
    if (self.titleView.activityImageView.image == nil) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请选择活动图片";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
    if (self.dateView.beginYearTextField.text.length <= 0 || self.dateView.beginMonthTextField.text.length <= 0 || self.dateView.beginDayTextField.text.length <= 0 || self.dateView.endYearTextField.text.length <= 0 || self.dateView.endMonthTextField.text.length <= 0 || self.dateView.endDayTextField.text.length <= 0) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入活动时间";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
    if (self.activityContentView.contentTextView.attributedText.length <= 0) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入活动内容";
        [hud hideAnimated:YES afterDelay:0.5];
        return;
    }
   
    [kWindow addSubview:self.popView];
    
    
}
- (void)activityTitleViewSelectImage:(ActivityTitleView *)titleView {
    TEST_LOG(@"选择标题图片");
    [self toPhotoLib:titleView];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    TEST_LOG(@"info = %@", info);
    if (picker == self.titleImagePickerController) {
        [self.titleView.addImageView removeFromSuperview];
        [self.titleView.addLabel removeFromSuperview];
        self.titleView.addImageView = nil;
        self.titleView.addLabel = nil;
        self.titleView.activityImageView.image = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (picker == self.contentImagePickerController) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        CGFloat width = self.activityContentView.contentTextView.width;
        CGFloat height = image.size.height / image.size.width * width;
        image = [image resizeImageWithSize:CGSizeMake(width, height)];
        NSTextAttachment *attachment = [NSTextAttachment new];
        attachment.image = image;
        [self.activityContentView.contentTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:self.activityContentView.contentTextView.selectedRange.location];
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)selectImageAction {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoLib = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf toPhotoLib:nil];
        
    }];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf toTakePhoto];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:photoLib];
    [alert addAction:takePhoto];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)toPhotoLib:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if (sender == self.titleView) {
        self.titleImagePickerController = imagePicker;
    } else {
        self.contentImagePickerController = imagePicker;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)toTakePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        self.takePhotoImagePickerController = imagePicker;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)activityPopView:(ActivityPopView *)popView didClickedCloseButton:(UIButton *)button {
    [self.popView removeFromSuperview];
    
}
- (void)activityPopView:(ActivityPopView *)popView didClickedCreateButton:(UIButton *)button {
    __weak typeof(self) weakSelf = self;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    hud.label.text = @"发布中，请稍候";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSMutableDictionary *para = [NSMutableDictionary new];
    para[@"userid"] = [User currentUser].ID;
    para[@"title"] = self.titleView.titleTextField.text;
    UIImage *image = self.titleView.activityImageView.image;
    image = image;
    TEST_LOG(@"image = %@", image);
    NSString *start = [NSString stringWithFormat:@"%@-%@-%@", self.dateView.beginYearTextField.text, self.dateView.beginMonthTextField.text, self.dateView.beginDayTextField.text];
    para[@"start"] = start;
    NSString *end = [NSString stringWithFormat:@"%@-%@-%@", self.dateView.endYearTextField.text, self.dateView.endMonthTextField.text, self.dateView.endDayTextField.text];
    para[@"end"] = end;
    NSAttributedString *content = self.activityContentView.contentTextView.attributedText;
    TEST_LOG(@"content = %@", content);
    para[@"content"] = content;
    [manager POST:@"http://www.ugohb.com/app/app.php?j=index&type=addactive" parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"img_path" fileName:@"image.png" mimeType:@"image/png"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TEST_LOG(@"发布活动数据 = %@", responseObject);
        int status = [responseObject[@"status"] intValue];
        if (status == 0) {
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"发布失败";
            [hud hideAnimated:YES afterDelay:1.5];
            return ;
        }
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发布成功";
        [hud hideAnimated:YES afterDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.popView removeFromSuperview];
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                [weakSelf.activityListController.tableView.mj_header beginRefreshing];
            }];
        });
       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TEST_LOG(@"发布活动错误 = %@", error);
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"发布失败";
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
    
    
}
- (void)activityPopView:(ActivityPopView *)popView didClickedCancelButton:(UIButton *)button {
    [self.popView removeFromSuperview];
    
}
@end
