#!/bin/bash
#
# Start help screen for terminal
#
# Copyright (C) 2015 Michael Müller
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
#

WINE_VERSION="$(wine --version)"

function _urlencode()
{
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}

function appdb()
{
    local name_encoded=$(_urlencode "$*")
    local url="http://appdb.winehq.org/objectManager.php?sClass=application&bIsQueue=false&bIsRejected=false&sTitle=Browse%20Applications&iItemsPerPage=25&iPage=1&iappFamily-appNameOp0=2&sappFamily-appNameData0=$name_encoded"
    open "$url" &> /dev/null
}

clear
echo "################################################################################"
echo "#                           Wine Is Not an Emulator                            #"
echo "################################################################################"
echo ""
echo " Welcome to $WINE_VERSION"
echo ""
echo " In order to start a program:"
printf "   .exe:\e[1;31m wine\e[0m\e[1;90m program.exe\e[0m\n"
printf "   .msi:\e[1;31m wine msiexec /i\e[0m\e[1;90m program.msi\e[0m\n"
echo ""
echo " If you want to configure wine:"
printf "  \e[1;31m winecfg\e[0m\n"
echo ""
echo " To get information about app compability:"
printf "  \e[1;31m appdb\e[0m\e[1;90m Program Name\e[0m\n"
echo ""