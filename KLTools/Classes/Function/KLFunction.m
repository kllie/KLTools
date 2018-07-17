//
//  KLFunction.m
//  KLTools
//
//  Created by neville on 2018/6/15.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "KLFunction.h"

@implementation KLFunction

+ (BOOL)checkNumber:(NSString *)numberString {
    BOOL res = YES;
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < numberString.length; i++) {
        NSString *string = [numberString substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
    }
    return res;
}

+ (BOOL)checkIdentityCard:(NSString *)cardString {
    
//    if (cardString.length != 18) {
//        return NO;
//    }
//    // 正则表达式判断基本 身份证号是否满足格式
//    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
//    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    // 如果通过该验证，说明身份证格式正确，但准确性还需计算
//    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
//
//    //** 开始进行校验 *//
//
//    //将前17位加权因子保存在数组里
//    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
//
//    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
//    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
//
//    //用来保存前17位各自乖以加权因子后的总和
//    NSInteger idCardWiSum = 0;
//    for(int i = 0;i < 17;i++) {
//        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
//        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
//        idCardWiSum+= subStrIndex * idCardWiIndex;
//    }
//
//    //计算出校验码所在数组的位置
//    NSInteger idCardMod=idCardWiSum%11;
//    //得到最后一位身份证号码
//    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
//    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
//    if(idCardMod==2) {
//        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
//            return NO;
//        }
//    }
//    else{
//        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
//        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
//            return NO;
//        }
//    }
    return YES;
}

+ (BOOL)checkBankCard:(NSString *)cardString {
    if (cardString.length == 0) {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardString.length; i++) {
        c = [cardString characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly = [digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo) {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        } else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

@end
