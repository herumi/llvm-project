# instruction histogram per function of x86 AT&T asm (64-bit q or 32-bit l suffix)
/^[A-Za-z_][A-Za-z0-9_]*:/ { if (name != "") flush(); name = $1; sub(":", "", name); delete n; tot = 0; sp = 0; next }
/^\t[a-z]/ {
	op = $1
	if (op ~ /^(mulx|adc|add|shld|shl|mov|movzb|imul|mul)[qlwb]$/) sub(/[qlwb]$/, "", op)
	tot++
	if ($0 ~ /[re]sp/) sp++
	n[op]++
}
END { if (name != "") flush() }
function flush() {
	printf "%-10s total=%3d sp=%3d mulx=%2d mul=%2d adc=%2d add=%2d setb=%2d movzb=%2d shld=%2d shl=%2d mov=%3d\n", name, tot, sp, n["mulx"], n["mul"] + n["imul"], n["adc"], n["add"], n["setb"] + n["setae"], n["movzb"], n["shld"], n["shl"], n["mov"]
}
