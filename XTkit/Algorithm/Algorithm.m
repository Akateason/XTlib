//
//  Algorithm.m
//  XTkit
//
//  Created by teason23 on 2017/11/4.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

+ (void)bubbleSortWithArray:(NSMutableArray *)arr
                    andSort:(Sort)sort
{
    for (int i = 0; i < arr.count - 1; i++) {
        for (int j = 0; j < arr.count - i - 1; j++) {
            NSNumber *num1 = arr[j] ;
            NSNumber *num2 = arr[j+1] ;
            if (sort(num1.intValue, num2.intValue)) {
                //                NSNumber *temp = arr[j+1] ;
                //                arr[j+1] = arr[j] ;
                //                arr[j] = temp ;
                [arr exchangeObjectAtIndex:j
                         withObjectAtIndex:j+1] ;
            }
        }
    }
}

int a[101] , n ;

+ (void)quickSortWithLeft:(int)left right:(int)right {
    int i,j,t,temp ;
    if (left > right) return ;
    
    temp = a[left] ;
    i = left ;
    j = right ;
    while (i != j) {
        while (a[j] >= temp && i < j) j-- ;
        while (a[i] <= temp && i < j) i++ ;
        
        if (i < j) {
            t = a[i] ;
            a[i] = a[j] ;
            a[j] = t ;
        }
    }
    
    a[left] = a[i] ;
    a[i] = temp ;
    
    [self quickSortWithLeft:left right:i - 1] ;
    [self quickSortWithLeft:i + 1 right:right] ;
}

@end
