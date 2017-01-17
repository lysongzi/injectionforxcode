//
//  $Id: //depot/injectionforxcode/InjectionPluginLite/Classes/INPluginClientController.h#1 $
//  InjectionPluginLite
//
//  Created by John Holdsworth on 15/01/2013.
//  Copyright (c) 2012 John Holdsworth. All rights reserved.
//
//  Manages interaction with client application and runs UNIX scripts.
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

#import <Cocoa/Cocoa.h>

@class INPluginMenuController;

@interface INPluginClientController : NSObject

@property (nonatomic,retain) IBOutlet NSPanel *consolePanel;     //相关信息输出面板
@property (nonatomic,retain) IBOutlet NSPanel *paramsPanel;      //参数面板

@property (nonatomic,retain) NSMutableDictionary *sourceFiles;   //源文件
@property (nonatomic,retain) NSString *scriptPath;               //脚本路径?
@property (nonatomic) BOOL withReset;                            //是否重置？

- (void)alert:(NSString *)msg;
- (void)setConnection:(int)clientConnection;                     //接受socket连接
- (void)runScript:(NSString *)script withArg:(NSString *)selectedFile;  //执行脚本
- (void)writeString:(NSString *)string;                                 //写啥数据呢？
- (BOOL)connected;                                                      //判断是否是连接状态？

@end
