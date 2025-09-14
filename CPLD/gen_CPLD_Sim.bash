

for i in {0..4096}
do
	binary_convert=$(printf "%013d" "$(echo "obase=2;$i" | bc)")
	echo "C 1 ${binary_convert} ************* ************* 1 1 * ****** * * * *"
done
