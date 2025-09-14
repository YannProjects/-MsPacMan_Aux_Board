source_addr_list=(0410 08E0 0A30 0BD0 0C20 0E58 0EA8 1000 1008 1288 1348 1688 16B0 16D8 16F8 19A8 19B8 2060 2108 21A0 2298 23E0 2418 2448 2470 2488 24B0 24D8 24F8 2748 2780 27B8 2800 2B20 2B30 2BF0 2CC0 2CD8 2CF0 2D60)
dest_addr_list=(8008 81D8 8118 80D8 8120 8168 8198 8020 8010 8098 8048 8088 8188 80C8 81C8 80A8 81A8 8148 8018 81A0 80A0 80E8 8000 8058 8140 8080 8180 80C0 81C0 8050 8090 8190 8028 8100 8110 81D0 80D0 80E0 81E0 8160)

for i in {0..39}
do
    echo "FIELD sel${i} = [match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i},match${i}];"
done

for i in {0..39}
do
    echo "match${i} = i_addr:['h'${source_addr_list[$i]}];"
done

rom_patched="rom_patched = "
for i in {0..39}
do
	rom_patched="$rom_patched (sel${i} & 'h'${dest_addr_list[$i]}) # "
done

echo $rom_patched