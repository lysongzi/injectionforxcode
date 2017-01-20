#!/usr/bin/perl -w

#  $Id: //depot/injectionforxcode/InjectionPluginLite/patchProject.pl#2 $
#  Injection
#
#  Created by John Holdsworth on 15/01/2013.
#  Copyright (c) 2012 John Holdsworth. All rights reserved.
#
#  These files are copyright and may not be re-distributed, whole or in part.
#

use strict;
use FindBin;
use lib $FindBin::Bin;
use common;

#@表示列表
#grep函数接受一个array，然后返回一个经过筛选的array。==.不知道筛选结果是啥
my @ip4Addresses = grep $_ !~ /:/, split " ", $addresses;
shift @ip4Addresses; # bonjour address seems unreliable, 为啥又从队列头部弹出这玩意。。

#%是哈希表
my %ipPrecedence = (
    10 => 2,
    192 => 1,
    169 => -1,
    172 => -2,
    127 => -9,
);

# 这是一个方法，$_[0]是传入的第一个参数
# =~是"dont match"的意思，正则表达判断是不是
sub prec {
    my ($network) = $_[0] =~ /^(\d+)\./;
    return $ipPrecedence{$network} || 0; #ipPrecedence{$network}根据键取对应的值？？？
}

# ip地址排序
# <=>表示比较大小，返回0-1，0，1
@ip4Addresses = sort { prec($b) <=> prec($a) } @ip4Addresses;

my $key = "// From here to end of file added by Injection Plugin //";
my $ifdef = $projName =~ /UICatalog|(iOS|OSX)GLEssentials/ ?
    "__OBJC__ // would normally be DEBUG" : "DEBUG";

# 输出信息 \b表示单词边界？
print "\\b Patching project contained in: $projRoot\n";

###################################################################################################
# patch project .pch files (if not using AppCode)
#if ( !$isAppCode ) {
#    patchAll( "refix.pch|Bridging-Header-Not.h", sub {
#    $_[0] =~ s/\n*($key.*)?$/<<CODE/es;
#
#
#$key
#
##ifdef $ifdef
##define INJECTION_ENABLED
#
##import "$resources/BundleInterface.h"
##endif
#CODE
#    } );
#}

# .= 操作有点是像 += 字符串连接。。。
$ifdef .= "\n#define INJECTION_PORT $selectedFile" if $isAppCode || $selectedFile; # if条件成立则做那个赋值操作

###################################################################################################
# patch normal Xcode projects
# linux shell 脚本？ !-d 表示不是目录？所以-d是表示判断是不是目录?
if ( !-d "$projRoot$projName.approj" ) {
    #执行这个patch方法
    patchAll( "\./main.(m|mm)", sub {
        $_[0] =~ s/\n*($key.*)?$/<<CODE/es;


$key

#ifdef $ifdef
static char _inMainFilePath[] = __FILE__;
static const char *_inIPAddresses[] = {@{[join ', ', map "\"$_\"", @ip4Addresses]}, 0};

#define INJECTION_ENABLED
#import "$resources/BundleInjection.h"
#endif
CODE
    } ) or error "Could not locate project's main.(m|mm) to patch.\nTo patch a Swift project please create an empty main.m";
}

###################################################################################################
# patch projects using apportable
else {
    patchAll( "main.(m|mm)", sub {
        $_[0] =~ s/\n+$key.*/\n/s;
    } );

    patchAll( "AppDelegate.(m|mm)", sub {
        $_[0] =~ s/^/<<CODE/es and

#define DEBUG 1 // for Apportable
#ifdef $ifdef
static char _inMainFilePath[] = __FILE__;
static const char *_inIPAddresses[] = {@{[join ', ', map "\"$_\"", @ip4Addresses]}, 0};

#define INJECTION_ENABLED
#import "$resources/BundleInjection.h"
#endif

// From start of file to here added by Injection Plugin //

CODE
    $_[0] =~ s/(didFinishLaunching.*?{[^\n]*\n)/<<CODE/sie;
$1#ifdef DEBUG
    [BundleInjection load];
#endif
CODE
    } );
}

###################################################################################################
# ensure symbols exported
#my $dontHideSymbols = "GCC_SYMBOLS_PRIVATE_EXTERN = NO;";
#patchAll( "project.pbxproj", sub {
#    $_[0] =~ s@(/\* Debug \*/ = \{[^{]*buildSettings = \{(\s*)[^}]*)(};)@$1$dontHideSymbols$2$3@g
#        if $_[0] !~ /$dontHideSymbols/;
#} );
