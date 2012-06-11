#!/bin/bash 

# Copyright (c) 2012 Manuel Weichselbaumer.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Your prefix
PREFIX=/opt/bblib


# Note that we explicitly put --without-x because the configure 
# system has been known to forget that we are cross compiling 
# and over-zealously look for x11 headers and find them in /usr/include. 

RANLIB="${QNX_HOST}/usr/bin/ntoarmv7-ranlib " \
CPP="${QNX_HOST}/usr/bin/qcc -V4.4.2,gcc_ntoarmv7le_cpp -E " \
CC="${QNX_HOST}/usr/bin/qcc -V4.4.2,gcc_ntoarmv7le_cpp " \
LD="${QNX_HOST}/usr/bin/ntoarmv7-ld " \
CPPFLAGS="-D__PLAYBOOK__ -D__QNXNTO__ " \
CFLAGS=" -g " \
LDFLAGS="-L${QNX_TARGET}/armle-v7/lib -L${PREFIX}/lib -lscreen -lasound -lpps -lm -lpng14 -lbps -lEGL -lGLESv2" \
PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig \
PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig \
./configure --prefix="${PREFIX}" \
            --build=i686-pc-linux \
            --host=arm-unknown-nto-qnx6.5.0eabi \
            --disable-nls \
            --disable-static \
            --disable-loadsave \
            --disable-check \
            --disable-examples \
            --disable-tests
#            --with-pkg-config-path=${PREFIX}/lib/pkgconfig

PREFIX=${PREFIX} make all


if [ $? != 0 ]; then
  echo "Build Failed!"
  exit 1
fi

PREFIX=${PREFIX} make install


echo "Build Successful!!"
exit 0
