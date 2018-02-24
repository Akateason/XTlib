# XTReq
* 基于AFNetworking代码最少的请求框架.
* 无内存泄露
* 同步异步
* GET / POST / PUT , header , formData , rawbody
* 带progessHUD
* 取消
* 持久化保存
* 指定三种不同的保存策略
* 可手动保存可控


cocoapods 
```
pod 'XTReq'
```

```
#import "XTReq.h"
```

# XTRequest
1.  share one manager .
2.  async and sync .
3.  GET / POST / PUT , fast append HTTP header / formdata / rawbody
4.  log result
5.  show hud
6. cancel all req

#  XTCacheRequest
1.  Persistent save the response of requests .
2.  three policy for how you save requests .
3.  can control save or not when server crashed or bug .

---

* 使用示例 供参考

## XTRequest
### async
```
[XTRequest GETWithUrl:kURLstr
            header:nil
            hud:YES
            parameters:nil
            taskSuccess:^(NSURLSessionDataTask *task, id json) {

        } fail:^{

    }] ;
```

### raw body
```
[XTRequest POSTWithURL:url
                header:
                param:
                rawBody:
                hud:
                success:
                fail: ] ;
```

### sync
```
id json = [XTRequest syncWithReqMode:
                                 url:
                              header:
                              parameters:] ;
```


---

## XTCacheRequest

#### 若需要缓存. 需在APPdelegate配置, 传入你的数据库名, 如果有的话.
```
[XTCacheRequest configXTCacheReqWhenAppDidLaunchWithDBName:@"yourDB"] ;

```


### 最通常的情况, 一行调用
```
[XTCacheRequest cacheGET:
                parameters:
                completion:^(id json) {

}] ;
```

### 缓存策略
```
***XTResponseCacheType***
*  XTResponseCachePolicyNeverUseCache  从不缓存适合每次都实时的数据流.
*  XTResponseCachePolicyAlwaysCache    总是获取缓存的数据.不再更新.
*  XTResponseCachePolicyTimeout        规定时间内.返回缓存.超时则更新数据. 需设置timeout时间. timeout默认1小时
```

### 你也可指定三种不同的保存策略 以定时为例.设计定时超出时间.s为单位.
### XTResponseCachePolicy
```
[XTCacheRequest cacheGET:kURLstr
                header:nil
                parameters:nil
                hud:YES
                policy:XTResponseCachePolicyTimeout
                timeoutIfNeed:10 * 60
                completion:^(id json) {

}] ;
```

### 防止服务器出bug或者崩溃的处理方法
### 控制是否保存
* XTReqSaveJudgment_willSave
* XTReqSaveJudgment_NotSave

```
[XTCacheRequest cacheGET:kURLstr
                parameters:nil
                judgeResult:^XTReqSaveJudgment(id json) {
                    if (!json) {
                        return XTReqSaveJudgment_NotSave ; // 数据格式不对. 则不保存的情况.
                    }
                    else {
                        [self showInfoInAlert:[json yy_modelToJSONString]] ;
                        return XTReqSaveJudgment_willSave ;
                    }
}] ;
```



