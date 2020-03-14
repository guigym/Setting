#!/usr/bin/bash

read -p "Please Enter select(1:git;2:bit_intel): " SEL
case "$SEL" in
    1)
        echo "here is the git user information!"
        git config user.name "guigym"
        git config user.email  "wuchunbostudent1@163.com"
        git config user.name
        git config user.email
        ;;
    2)
        echo "here is the bit-bucket user information!"
        git config user.name "chunbowu"
        git config user.email  "chunbo.wu@intel.com"
        git config user.name
        git config user.email
        ;;
    *)
        echo "there is only 1/2 choices!!"
        ;;
esac

