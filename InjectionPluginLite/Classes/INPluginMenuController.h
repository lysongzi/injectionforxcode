//
//  $Id: //depot/injectionforxcode/InjectionPluginLite/Classes/INPluginMenuController.h#1 $
//  InjectionPluginLite
//
//  Created by John Holdsworth on 15/01/2013.
//  Copyright (c) 2012 John Holdsworth. All rights reserved.
//
//  Manages interactions with Xcode's product menu and runs TCP server.
//
//  This file is copyright and may not be re-distributed, whole or in part.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <WebKit/WebKit.h>

@class INPluginClientController;
@interface INPluginMenuController : NSObject <NSApplicationDelegate>

@property (nonatomic,retain) IBOutlet NSButton *watchButton;                             //启动文件监测功能按钮
@property (nonatomic,retain) IBOutlet INPluginClientController *client;                  //客户端对象？？？
@property (nonatomic,retain) NSMutableDictionary<NSString *,NSDate *> *lastInjected;     //最后注入代码文件字典，文件名为key，最后注入时间为value
@property (nonatomic,retain) NSString *lastFile;                                         //最后修改文件？

- (NSUserDefaults *)defaults;  //默认设置项
- (NSArray *)serverAddresses;  //服务器地址列表
- (NSString *)workspacePath;   //工作区目录路径

- (void)error:(NSString *)format, ...;     //输出错误信息
- (void)enableFileWatcher:(BOOL)enabled;   //启动/禁用文件检测功能
- (IBAction)watchChanged:sender;           //文件监测功能按钮响应方法

- (void)startProgress;                     //启动进度条，注入代码右上角有个进度条
- (void)setProgress:(NSNumber *)fraction;  //设置状态条进度

- (NSString *)buildDirectory;  //构建目录
- (NSString *)logDirectory;    //日志目录
- (NSString *)xcodeApp;        //？？？

@end

extern INPluginMenuController *injectionPlugin;
