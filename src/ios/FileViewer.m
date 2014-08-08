#import "CDVFileViewer.h"
#import <Cordova/CDV.h>

#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation CDVFileViewer
@synthesize controller = docController;

- (void) openDocument: (CDVInvokedUrlCommand*)command {

    NSString *path = [command.arguments objectAtIndex:0];
    
    CDVViewController* cont = (CDVViewController*)[ super viewController ];

    NSArray *dotParts = [path componentsSeparatedByString:@"."];
    NSString *fileExt = [dotParts lastObject];

    NSString *uti = (__bridge NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)fileExt, NULL);

    NSURL *fileURL = nil;
    fileURL = [NSURL fileURLWithPath:path];
        
    localFile = fileURL.path;

    docController = [UIDocumentInteractionController  interactionControllerWithURL:fileURL];
    docController.delegate = self;
    docController.UTI = uti;
            
    CDVPluginResult* pluginResult = nil;
    BOOL wasOpened = [docController presentOptionsMenuFromRect:CGRectZero inView:cont.view animated:YES];
            
    if(wasOpened) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @""];
    } else {
        NSDictionary *jsonObj = [ [NSDictionary alloc]
                                    initWithObjectsAndKeys :
                                    @"9", @"status",
                                    @"Could not handle UTI", @"message",
                                    nil
                                    ];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonObj];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
     
}

@end
