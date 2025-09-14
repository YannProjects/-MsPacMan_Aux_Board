source_addr_list=(0410 08E0 0A30 0BD0 0C20 0E58 0EA8 1000 1008 1288 1348 1688 16B0 16D8 16F8 19A8 19B8 2060 2108 21A0 2298 23E0 2418 2448 2470 2488 24B0 24D8 24F8 2748 2780 27B8 2800 2B20 2B30 2BF0 2CC0 2CD8 2CF0 2D60)
dest_addr_list=(8008 81D8 8118 80D8 8120 8168 8198 8020 8010 8098 8048 8088 8188 80C8 81C8 80A8 81A8 8148 8018 81A0 80A0 80E8 8000 8058 8140 8080 8180 80C0 81C0 8050 8090 8190 8028 8100 8110 81D0 80D0 80E0 81E0 8160)

patch_addr_filter=""
for i in {0..6}
do
	source_addr=${source_addr_list[$i]}
	
	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:4:${#source_binary}-7}"
	patch_addr_filter="$patch_addr_filter (i_addr:'b'$trimmed_src) #"
done
echo "patch_match_a = $patch_addr_filter"

patch_addr_filter=""
for i in {7..16}
do
	source_addr=${source_addr_list[$i]}
	
	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:4:${#source_binary}-7}"
	patch_addr_filter="$patch_addr_filter (i_addr:'b'$trimmed_src) #"

done
echo "patch_match_b = $patch_addr_filter"

patch_addr_filter=""
for i in {17..39}
do
	source_addr=${source_addr_list[$i]}
	
	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:4:${#source_binary}-7}"
	patch_addr_filter="$patch_addr_filter (i_addr:'b'$trimmed_src) #"

done
echo "patch_match_c = $patch_addr_filter"

echo "Table i_addr => rom_patched"
echo "{"
for i in {0..39}
do
	source_addr=${source_addr_list[$i]}
	
	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:0:${#source_binary}-3}"	
	
	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
	trimmed_dest="${dest_binary:0:${#dest_binary}-3}"
	
	echo "     /* $source_addr */"
	echo "     'b'$trimmed_src => 'b'$trimmed_dest;"
done
echo "}"
echo

echo "Table addr_b => patched_addr_b"
echo "{"
for i in {7..16}
do
	source_addr=${source_addr_list[$i]}
	
	source_binary=$(printf "%16d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:4:${#source_binary}-7}"	
	
	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
	trimmed_dest="${dest_binary:7:${#dest_binary}-10}"
	
	echo "     /* $source_addr */"
	echo "     'b'$trimmed_src => 'b'$trimmed_dest;"
done
echo "}"
echo

echo "Table addr_c => patched_addr_c"
echo "{"
for i in {17..39}
do
	source_addr=${source_addr_list[$i]}

	source_binary=$(printf "%16d" "$(echo "ibase=16;obase=2;$source_addr" | bc)")
	trimmed_src="${source_binary:4:${#source_binary}-7}"	
	
	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
	trimmed_dest="${dest_binary:7:${#dest_binary}-10}"
	
	echo "     /* $source_addr */"
	echo "     'b'$trimmed_src => 'b'$trimmed_dest;"
	hash_values+=("$hash_addr_hex")
done
echo "}"
echo



#echo "Table full_addr_x0 => rom_patched_a"
#echo "{"
#for i in {0..39}
#do
#	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${source_addr_list[$i]}" | bc)")
#	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
#	trimmed_src="${source_binary:4:${#source_binary}-7}"
#	trimmed_dest="${dest_binary:7:${#dest_binary}-10}"
#	echo "     /* 0x${source_addr_list[$i]} => 0x${dest_addr_list[$i]} */"
#	echo "    'b'${trimmed_src} => 'b'${trimmed_dest};"
#done
#echo "}"

#for i in {0..39}
#do
#	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${source_addr_list[$i]}" | bc)")
#	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
#	trimmed_src="${source_binary:4:${#source_binary}-7}"
#	trimmed_dest="${dest_binary:7:${#dest_binary}-10}"
#	echo "     /* 0x${source_addr_list[$i]} => 0x${dest_addr_list[$i]} */"
#	echo "    'b'${trimmed_src} => 'b'${trimmed_dest};"
#done

#for i in {0..39}
#do
#	match_addr_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${source_addr_list[$i]}" | bc)")
#	trimmed_match_addr="${match_addr_binary:3:${#match_addr_binary}-3}"
#	match="$match # (i_addr:['b'$trimmed_match_addr])"
#done
#echo $match

#echo "Table full_addr_x1 => rom_patched_b"
#echo "{"
#for i in {7..16}
#do
#	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${source_addr_list[$i]}" | bc)")
#	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
#	trimmed_src="${source_binary:4:${#source_binary}-7}"
#	trimmed_dest="${dest_binary:4:${#dest_binary}-7}"
#	echo "     /* 0x${source_addr_list[$i]} => 0x${dest_addr_list[$i]} */"
#	echo "    'b'${trimmed_src} => 'b'${trimmed_dest};"
#done
#echo "}"

#echo "Table full_addr_x2 => rom_patched_c"
#echo "{"
#for i in {17..39}
#do
#	source_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${source_addr_list[$i]}" | bc)")
#	dest_binary=$(printf "%016d" "$(echo "ibase=16;obase=2;${dest_addr_list[$i]}" | bc)")
#	trimmed_src="${source_binary:4:${#source_binary}-7}"
#	trimmed_dest="${dest_binary:4:${#dest_binary}-7}"
#	echo "     /* 0x${source_addr_list[$i]} => 0x${dest_addr_list[$i]} */"
#	echo "    'b'${trimmed_src} => 'b'${trimmed_dest};"
#done
#echo "}"