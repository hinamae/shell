#!/bin/sh


#aオプションが指定されたか確認するフラグ．0で初期化
a_flag=0
#
separator=""

#while分の条件式としてgetoptsを書いてそのwhileループの内部のcase文で判断する

while getopts "ap:" option
do
	case $option in
		a)
			#aオプションが指定された場合はa_flagを1とする
			a_flag=1
			;;
		p)
		        #$OPTARGとしてにpのあとに書いた数が代入されている
			separator="$OPTARG"
			;;
		\?)
			#getoptsで無効なオプションが指定された場合，?が代入される
			echo "Usage: getopts.sh [-a] [-p separator] target_dir" 1>&2
			exit 1
			;;
	esac
done


#$1として第n引数をとりだしたいので!
shift $(expr $OPTIND - 1)
path="$1"

if [ $a_flag -eq 1 ]; then
	ls -a -- "$path"
else
	ls -- "$path"
fi

#testコマンドの引数nで$separator文字列が入っている場合のみ出力
if [ -n "$separator" ]; then
	echo "$separator"
fi
