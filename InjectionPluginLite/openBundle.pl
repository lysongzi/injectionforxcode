#!/usr/bin/perl -w

#  $Id: //depot/injectionforxcode/InjectionPluginLite/openBundle.pl#1 $
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

#执行shell脚本打开文件
system "open \"$InjectionBundle/InjectionBundle.xcodeproj\"";
