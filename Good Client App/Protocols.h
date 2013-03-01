@class ServiceController;
@class GoodClientViewController;

@protocol ServiceControllerDelegate <NSObject>
-(void)showAlert:(id)serviceReply;
@end

@protocol GoodClientViewControllerDelegate <NSObject>
-(void)fileTypeSelected:(NSString *)fileType;
@end