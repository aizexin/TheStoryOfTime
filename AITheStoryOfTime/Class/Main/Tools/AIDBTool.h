//
//  XLDBModel.h
//  iOS7.2爱限免
//
//  Created by MS on 15-9-23.
//  Copyright (c) 2015年 xuli. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AIEverydayCellModel;
@interface AIDBTool : NSObject

/**创建数据库 */
+(instancetype)shareDBTool;
/**向表格中插入数据*/
-(void)insertEverydayCellModel:(AIEverydayCellModel*)everydayCellModel;
/**删除对应id的数据*/
-(void)deleteEverdayCellModelWithID:(NSInteger)index;
/**查询everday全部数据*/
-(NSMutableArray*)selectAllEverdayCellModel;
/**
 *  创建everyday的table
 */
-(void)createEverdayTable;
@end
