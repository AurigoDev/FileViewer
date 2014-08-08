#import <Cordova/CDV.h>

@interface CDVFileViewer : CDVPlugin <UIDocumentInteractionControllerDelegate> {
    NSString *localFile;
}

@property(nonatomic, strong) UIDocumentInteractionController *controller;

- (void) openDocument: (CDVInvokedUrlCommand*)command;

@end