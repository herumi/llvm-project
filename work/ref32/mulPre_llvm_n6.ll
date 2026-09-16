@llvm_n6_p = dso_local local_unnamed_addr global i192 3138550867693340381917894711603833208051177722232017256449
@ip = internal unnamed_addr constant i32 4294967295
@pStr = private unnamed_addr constant [51 x i8] c"0x800000000000000000000000000000000000000000000001\00"
define i8* @llvm_n6_get_prime()
{
%r2 = bitcast [51 x i8] *@pStr to i8*
ret i8* %r2
}
define private i64 @mul32x32L(i32 %r2, i32 %r3)
{
%r4 = zext i32 %r2 to i64
%r5 = zext i32 %r3 to i64
%r6 = mul i64 %r4, %r5
ret i64 %r6
}
define private i32 @extractHigh32(i64 %r2)
{
%r3 = lshr i64 %r2, 32
%r4 = trunc i64 %r3 to i32
ret i32 %r4
}
define private i64 @mulPos32x32(i32* noalias %r2, i32 %r3, i32 %r4)
{
%r5 = getelementptr i32, i32* %r2, i32 %r4
%r6 = load i32, i32* %r5
%r7 = call i64 @mul32x32L(i32 %r6, i32 %r3)
ret i64 %r7
}
define private i224 @llvm_n6_mulUnit(i32* noalias %r2, i32 %r3) alwaysinline
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 2)
%r11 = trunc i64 %r10 to i32
%r12 = call i32 @extractHigh32(i64 %r10)
%r13 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 3)
%r14 = trunc i64 %r13 to i32
%r15 = call i32 @extractHigh32(i64 %r13)
%r16 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 4)
%r17 = trunc i64 %r16 to i32
%r18 = call i32 @extractHigh32(i64 %r16)
%r19 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 5)
%r20 = trunc i64 %r19 to i32
%r21 = call i32 @extractHigh32(i64 %r19)
%r22 = zext i32 %r5 to i64
%r23 = zext i32 %r8 to i64
%r24 = shl i64 %r23, 32
%r25 = or i64 %r22, %r24
%r26 = zext i64 %r25 to i96
%r27 = zext i32 %r11 to i96
%r28 = shl i96 %r27, 64
%r29 = or i96 %r26, %r28
%r30 = zext i96 %r29 to i128
%r31 = zext i32 %r14 to i128
%r32 = shl i128 %r31, 96
%r33 = or i128 %r30, %r32
%r34 = zext i128 %r33 to i160
%r35 = zext i32 %r17 to i160
%r36 = shl i160 %r35, 128
%r37 = or i160 %r34, %r36
%r38 = zext i160 %r37 to i192
%r39 = zext i32 %r20 to i192
%r40 = shl i192 %r39, 160
%r41 = or i192 %r38, %r40
%r42 = zext i32 %r6 to i64
%r43 = zext i32 %r9 to i64
%r44 = shl i64 %r43, 32
%r45 = or i64 %r42, %r44
%r46 = zext i64 %r45 to i96
%r47 = zext i32 %r12 to i96
%r48 = shl i96 %r47, 64
%r49 = or i96 %r46, %r48
%r50 = zext i96 %r49 to i128
%r51 = zext i32 %r15 to i128
%r52 = shl i128 %r51, 96
%r53 = or i128 %r50, %r52
%r54 = zext i128 %r53 to i160
%r55 = zext i32 %r18 to i160
%r56 = shl i160 %r55, 128
%r57 = or i160 %r54, %r56
%r58 = zext i160 %r57 to i192
%r59 = zext i32 %r21 to i192
%r60 = shl i192 %r59, 160
%r61 = or i192 %r58, %r60
%r62 = zext i192 %r41 to i224
%r63 = zext i192 %r61 to i224
%r64 = shl i224 %r63, 32
%r65 = add i224 %r62, %r64
ret i224 %r65
}
define void @llvm_n6_sqrPre(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 0
%r4 = load i32, i32* %r3
%r5 = getelementptr i32, i32* %r2, i32 1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r2, i32 2
%r8 = load i32, i32* %r7
%r9 = getelementptr i32, i32* %r2, i32 3
%r10 = load i32, i32* %r9
%r11 = getelementptr i32, i32* %r2, i32 4
%r12 = load i32, i32* %r11
%r13 = getelementptr i32, i32* %r2, i32 5
%r14 = load i32, i32* %r13
%r15 = zext i32 %r4 to i64
%r16 = zext i32 %r14 to i64
%r17 = mul i64 %r15, %r16
%r18 = zext i32 %r4 to i64
%r19 = zext i32 %r12 to i64
%r20 = mul i64 %r18, %r19
%r21 = zext i32 %r6 to i64
%r22 = zext i32 %r14 to i64
%r23 = mul i64 %r21, %r22
%r24 = zext i64 %r20 to i128
%r25 = zext i64 %r23 to i128
%r26 = shl i128 %r25, 64
%r27 = or i128 %r24, %r26
%r28 = zext i64 %r17 to i128
%r29 = shl i128 %r28, 32
%r30 = add i128 %r29, %r27
%r31 = zext i32 %r4 to i64
%r32 = zext i32 %r10 to i64
%r33 = mul i64 %r31, %r32
%r34 = zext i32 %r6 to i64
%r35 = zext i32 %r12 to i64
%r36 = mul i64 %r34, %r35
%r37 = zext i32 %r8 to i64
%r38 = zext i32 %r14 to i64
%r39 = mul i64 %r37, %r38
%r40 = zext i64 %r33 to i128
%r41 = zext i64 %r36 to i128
%r42 = shl i128 %r41, 64
%r43 = or i128 %r40, %r42
%r44 = zext i128 %r43 to i192
%r45 = zext i64 %r39 to i192
%r46 = shl i192 %r45, 128
%r47 = or i192 %r44, %r46
%r48 = zext i128 %r30 to i192
%r49 = shl i192 %r48, 32
%r50 = add i192 %r49, %r47
%r51 = zext i32 %r4 to i64
%r52 = zext i32 %r8 to i64
%r53 = mul i64 %r51, %r52
%r54 = zext i32 %r6 to i64
%r55 = zext i32 %r10 to i64
%r56 = mul i64 %r54, %r55
%r57 = zext i32 %r8 to i64
%r58 = zext i32 %r12 to i64
%r59 = mul i64 %r57, %r58
%r60 = zext i32 %r10 to i64
%r61 = zext i32 %r14 to i64
%r62 = mul i64 %r60, %r61
%r63 = zext i64 %r53 to i128
%r64 = zext i64 %r56 to i128
%r65 = shl i128 %r64, 64
%r66 = or i128 %r63, %r65
%r67 = zext i128 %r66 to i192
%r68 = zext i64 %r59 to i192
%r69 = shl i192 %r68, 128
%r70 = or i192 %r67, %r69
%r71 = zext i192 %r70 to i256
%r72 = zext i64 %r62 to i256
%r73 = shl i256 %r72, 192
%r74 = or i256 %r71, %r73
%r75 = zext i192 %r50 to i256
%r76 = shl i256 %r75, 32
%r77 = add i256 %r76, %r74
%r78 = zext i32 %r4 to i64
%r79 = zext i32 %r6 to i64
%r80 = mul i64 %r78, %r79
%r81 = zext i32 %r6 to i64
%r82 = zext i32 %r8 to i64
%r83 = mul i64 %r81, %r82
%r84 = zext i32 %r8 to i64
%r85 = zext i32 %r10 to i64
%r86 = mul i64 %r84, %r85
%r87 = zext i32 %r10 to i64
%r88 = zext i32 %r12 to i64
%r89 = mul i64 %r87, %r88
%r90 = zext i32 %r12 to i64
%r91 = zext i32 %r14 to i64
%r92 = mul i64 %r90, %r91
%r93 = zext i64 %r80 to i128
%r94 = zext i64 %r83 to i128
%r95 = shl i128 %r94, 64
%r96 = or i128 %r93, %r95
%r97 = zext i128 %r96 to i192
%r98 = zext i64 %r86 to i192
%r99 = shl i192 %r98, 128
%r100 = or i192 %r97, %r99
%r101 = zext i192 %r100 to i256
%r102 = zext i64 %r89 to i256
%r103 = shl i256 %r102, 192
%r104 = or i256 %r101, %r103
%r105 = zext i256 %r104 to i320
%r106 = zext i64 %r92 to i320
%r107 = shl i320 %r106, 256
%r108 = or i320 %r105, %r107
%r109 = zext i256 %r77 to i320
%r110 = shl i320 %r109, 32
%r111 = add i320 %r110, %r108
%r112 = zext i320 %r111 to i352
%r113 = add i352 %r112, %r112
%r114 = zext i352 %r113 to i384
%r115 = shl i384 %r114, 32
%r116 = zext i32 %r4 to i64
%r117 = zext i32 %r4 to i64
%r118 = mul i64 %r116, %r117
%r119 = zext i32 %r6 to i64
%r120 = zext i32 %r6 to i64
%r121 = mul i64 %r119, %r120
%r122 = zext i32 %r8 to i64
%r123 = zext i32 %r8 to i64
%r124 = mul i64 %r122, %r123
%r125 = zext i32 %r10 to i64
%r126 = zext i32 %r10 to i64
%r127 = mul i64 %r125, %r126
%r128 = zext i32 %r12 to i64
%r129 = zext i32 %r12 to i64
%r130 = mul i64 %r128, %r129
%r131 = zext i32 %r14 to i64
%r132 = zext i32 %r14 to i64
%r133 = mul i64 %r131, %r132
%r134 = zext i64 %r118 to i128
%r135 = zext i64 %r121 to i128
%r136 = shl i128 %r135, 64
%r137 = or i128 %r134, %r136
%r138 = zext i128 %r137 to i192
%r139 = zext i64 %r124 to i192
%r140 = shl i192 %r139, 128
%r141 = or i192 %r138, %r140
%r142 = zext i192 %r141 to i256
%r143 = zext i64 %r127 to i256
%r144 = shl i256 %r143, 192
%r145 = or i256 %r142, %r144
%r146 = zext i256 %r145 to i320
%r147 = zext i64 %r130 to i320
%r148 = shl i320 %r147, 256
%r149 = or i320 %r146, %r148
%r150 = zext i320 %r149 to i384
%r151 = zext i64 %r133 to i384
%r152 = shl i384 %r151, 320
%r153 = or i384 %r150, %r152
%r154 = add i384 %r115, %r153
%r155 = bitcast i32* %r1 to i384*
store i384 %r154, i384* %r155
ret void
}
