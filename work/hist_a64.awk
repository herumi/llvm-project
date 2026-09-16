# instruction histogram per function of AArch64 asm (Linux ELF or Mach-O)
/^_?[A-Za-z][A-Za-z0-9_]*:/ { if (name != "") flush(); name = $1; sub(":", "", name); sub(/^_/, "", name); delete n; tot = 0; sp = 0; next }
/^\t[a-z]/ {
	op = $1
	tot++
	if ($0 ~ /\[sp/) sp++
	n[op]++
}
END { if (name != "") flush() }
function flush() {
	printf "%-10s total=%3d sp=%3d mul=%2d umulh=%2d adds=%2d adcs=%2d adc=%2d add=%2d cinc=%2d extr=%2d lsl=%2d orr=%2d mov=%3d ldr=%2d str=%2d\n", name, tot, sp, n["mul"], n["umulh"], n["adds"], n["adcs"], n["adc"], n["add"], n["cinc"] + n["cset"], n["extr"], n["lsl"] + n["lsr"], n["orr"], n["mov"], n["ldr"] + n["ldp"], n["str"] + n["stp"]
}
