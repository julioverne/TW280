#import <dlfcn.h>
#import <objc/runtime.h>
#import <substrate.h>
#import <CoreFoundation/CoreFoundation.h>

#define NSLog(...)

%hook TFNTwitterAccount
- (NSUInteger)maximumCharacterCount
{
	return %orig * 2;
}
%end


static BOOL tmpDisable;

%hook NSString
- (const char*)UTF8String
{
	if(!tmpDisable && [self rangeOfString:@"&tweet_mode="].location != NSNotFound && [self rangeOfString:@"&status="].location != NSNotFound && [self rangeOfString:@"&weighted_character_count=true"].location == NSNotFound) {
		NSString* arg1St = [self stringByAppendingString:@"&weighted_character_count=true"];
		NSLog(@"UTF8String: %@", arg1St);
		tmpDisable = YES;
		const char* rets = [arg1St UTF8String];
		tmpDisable = NO;
		return rets;
	}
	return %orig;
}
- (id)dataUsingEncoding:(unsigned long long)arg1
{	
	if(arg1 != 469578 && [self rangeOfString:@"&tweet_mode="].location != NSNotFound && [self rangeOfString:@"&status="].location != NSNotFound && [self rangeOfString:@"&weighted_character_count=true"].location == NSNotFound) {
		NSString* arg1St = [self stringByAppendingString:@"&weighted_character_count=true"];
		NSLog(@"dataUsingEncoding: %@", arg1St);
		return [arg1St dataUsingEncoding:469578];
	}
	if(arg1 == 469578) {
		arg1 = NSUTF8StringEncoding;
	}
	return %orig(arg1);
}
%end

