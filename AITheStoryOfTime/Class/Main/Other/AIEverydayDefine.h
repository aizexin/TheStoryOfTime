//
//  AIEverydayDefine.h
//  AITheStoryOfTime
//
//  Created by 艾泽鑫 on 15/10/24.
//  Copyright (c) 2015年 aizexin. All rights reserved.
//

#ifndef AITheStoryOfTime_AIEverydayDefine_h
#define AITheStoryOfTime_AIEverydayDefine_h

#define SC_APP_SIZE         [[UIScreen mainScreen] applicationFrame].size
#define CAMERA_TOPVIEW_HEIGHT   44  //title
#define AIEverydayPhotoRect CGRectMake(0, 0, SC_APP_SIZE.width, SC_APP_SIZE.width + CAMERA_TOPVIEW_HEIGHT)

//基准线颜色
#define AIEverydayLineColor [UIColor whiteColor]
//基准线背景宽度
#define AILineBgWith 21
#define AIShowLineX (AILineBgWith+1)*0.5
#endif
