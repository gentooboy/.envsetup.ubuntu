#!/bin/bash

PATH=$PATH:$envsetup

android_tools=$ANDROID_SDK_PATH/tools
if [[ "$android_tools" != "" ]]; then
    PATH=$android_tools:$PATH
fi

android_platform_tools=$ANDROID_SDK_PATH/platform-tools
if [[ "$android_platform_tools" != "" ]]; then
    PATH=$android_platform_tools:$PATH
fi

android_ndk=$ANDROID_NDK_PATH
if [[ "$android_ndk" != "" ]]; then
    PATH=$android_ndk:$PATH
fi

arndale_k_tool=$TOOL_MOUNTED/arm-2009q3/bin
if [[ "$arndale_k_tool" != "" ]]; then
    PATH=$arndale_k_tool:$PATH
fi

buck_build=$TOOL_MOUNTED/buck/bin
if [[ "$buck_build" != "" ]]; then
    PATH=$buck_build:$PATH
fi

WHITE="\[\e[1;37m\]"
GREEN="\[\e[0;32m\]"
CYAN="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
BLUE="\[\e[0;34m\]"
END="\[\e[m\]"

GIT_BRANCH="\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%r{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
GIT_BR_TAG='$(__git_ps1)'

PS1="${GREEN}\w${END}${GIT_BR_TAG}${BLUE}$ ${END}"

echo "    ~/.envsetup.$OS/pathsetup.sh sourced!!!"
