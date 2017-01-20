#!/usr/bin/perl -w

#  $Id: //depot/injectionforxcode/InjectionPluginLite/projectBuilt.pl#1 $
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
use IO::Socket::INET;
use IO::File;

# $ENV为环境变量,从环境变量中取出这两代码签名的值？
my $bundle = $ENV{CODESIGNING_FOLDER_PATH};
my $identity = $ENV{CODE_SIGN_IDENTITY}||"";

# message Xcode that app bundle has been built
# 通知xcode app bundle已经构建完毕？
my $socket = IO::Socket::INET->new( "localhost:31442" );
$socket->print( pack "iia*a*", length $identity, length $bundle, $identity, $bundle );

# also make info available for codesigning when injecting to a device
# 将方法签名这玩意也写出到设备中？
IO::File->new( "> /tmp/$ENV{USER}.ident")->print( "$bundle\n$identity\n" );
