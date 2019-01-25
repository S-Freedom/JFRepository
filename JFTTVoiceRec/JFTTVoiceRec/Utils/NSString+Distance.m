//
//  NSString+Distance.m
//  JFTTVoiceRec
//
//  Created by 黄鹏飞 on 2019/1/25.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "NSString+Distance.h"


static inline int min(int a, int b) {
    return a < b ? a : b;
}

@implementation NSString (Distance)

- (float) likePercent:(NSString *)target{
    int n = self.length;
    int m = target.length;
    if (m==0) return n;
    if (n==0) return m;
    
    //Construct a matrix, need C99 support
    int matrix[n+1][m+1];
    memset(&matrix[0], 0, m+1);
    for(int i=1; i<=n; i++) {
        memset(&matrix[i], 0, m+1);
        matrix[i][0]=i;
    }
    for(int i=1; i<=m; i++) {
        matrix[0][i]=i;
    }
    for(int i=1;i<=n;i++)
    {
        unichar si = [self characterAtIndex:i-1];
        for(int j=1;j<=m;j++)
        {
            unichar dj = [target characterAtIndex:j-1];
            int cost;
            if(si==dj){
                cost=0;
            }
            else{
                cost=1;
            }
            const int above=matrix[i-1][j]+1;
            const int left=matrix[i][j-1]+1;
            const int diag=matrix[i-1][j-1]+cost;
            matrix[i][j]=min(above,min(left,diag));
        }
    }
    return 100.0 - 100.0*matrix[n][m]/self.length;
}
@end
