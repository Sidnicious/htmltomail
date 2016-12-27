#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

int main(){
    // Thanks to catlan: https://stackoverflow.com/a/1958737/84745
    NSData* htmlData = [[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile];
    WebResource *mainResource = [[WebResource alloc] initWithData:htmlData
                                                              URL:[NSURL URLWithString:@"about:blank"]
                                                         MIMEType:@"text/html"
                                                 textEncodingName:@"utf-8"
                                                        frameName:nil];
    WebArchive *webArchive = [[WebArchive alloc] initWithMainResource:mainResource
                                                         subresources:nil
                                                     subframeArchives:nil];
    NSAppleEventDescriptor *mailAppleEventDescriptor = [NSAppleEventDescriptor
        descriptorWithDescriptorType:typeApplicationBundleID
                                data:[@"com.apple.mail" dataUsingEncoding:NSUTF8StringEncoding]];
    NSAppleEventDescriptor *appleEvent = [NSAppleEventDescriptor appleEventWithEventClass:'mail'
                                                                                  eventID:'mlpg'
                                                                         targetDescriptor:mailAppleEventDescriptor
                                                                                 returnID:kAutoGenerateReturnID
                                                                            transactionID:kAnyTransactionID];
    [appleEvent setParamDescriptor:[NSAppleEventDescriptor descriptorWithDescriptorType:'tdta'
                              data:[webArchive data]]
                        forKeyword:'----'];

    AEDesc reply = { typeNull, NULL };
    AESendMessage([appleEvent aeDesc], &reply, kAEWaitReply, kAEDefaultTimeout);

    return 0;
}
