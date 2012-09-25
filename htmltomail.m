#import <Cocoa/Cocoa.h>
#import "Helpers/ATMailHelper.h"

int main(){
    [ATMailHelper
        mailHTMLString:[
            [NSString alloc]
            initWithData:[[NSFileHandle fileHandleWithStandardInput] readDataToEndOfFile]
            encoding:NSUTF8StringEncoding
        ]
        baseURL:[NSURL URLWithString:@"about:blank"]
        subject:nil
        alternateMailToURL:nil
    ];
    return 0;
}
