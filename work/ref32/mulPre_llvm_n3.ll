@llvm_n3_p = dso_local local_unnamed_addr global i96 39614081257132168796771975169
@ip = internal unnamed_addr constant i32 4294967295
@pStr = private unnamed_addr constant [27 x i8] c"0x800000000000000000000001\00"
define i8* @llvm_n3_get_prime()
{
%r2 = bitcast [27 x i8] *@pStr to i8*
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
define private i128 @llvm_n3_mulUnit(i32* noalias %r2, i32 %r3) alwaysinline
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
%r13 = zext i32 %r5 to i64
%r14 = zext i32 %r8 to i64
%r15 = shl i64 %r14, 32
%r16 = or i64 %r13, %r15
%r17 = zext i64 %r16 to i96
%r18 = zext i32 %r11 to i96
%r19 = shl i96 %r18, 64
%r20 = or i96 %r17, %r19
%r21 = zext i32 %r6 to i64
%r22 = zext i32 %r9 to i64
%r23 = shl i64 %r22, 32
%r24 = or i64 %r21, %r23
%r25 = zext i64 %r24 to i96
%r26 = zext i32 %r12 to i96
%r27 = shl i96 %r26, 64
%r28 = or i96 %r25, %r27
%r29 = zext i96 %r20 to i128
%r30 = zext i96 %r28 to i128
%r31 = shl i128 %r30, 32
%r32 = add i128 %r29, %r31
ret i128 %r32
}
define void @llvm_n3_sqrPre(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 0
%r4 = load i32, i32* %r3
%r5 = getelementptr i32, i32* %r2, i32 1
%r6 = load i32, i32* %r5
%r7 = getelementptr i32, i32* %r2, i32 2
%r8 = load i32, i32* %r7
%r9 = zext i32 %r4 to i64
%r10 = zext i32 %r8 to i64
%r11 = mul i64 %r9, %r10
%r12 = zext i32 %r4 to i64
%r13 = zext i32 %r6 to i64
%r14 = mul i64 %r12, %r13
%r15 = zext i32 %r6 to i64
%r16 = zext i32 %r8 to i64
%r17 = mul i64 %r15, %r16
%r18 = zext i64 %r14 to i128
%r19 = zext i64 %r17 to i128
%r20 = shl i128 %r19, 64
%r21 = or i128 %r18, %r20
%r22 = zext i64 %r11 to i128
%r23 = shl i128 %r22, 32
%r24 = add i128 %r23, %r21
%r25 = zext i128 %r24 to i160
%r26 = add i160 %r25, %r25
%r27 = zext i160 %r26 to i192
%r28 = shl i192 %r27, 32
%r29 = zext i32 %r4 to i64
%r30 = zext i32 %r4 to i64
%r31 = mul i64 %r29, %r30
%r32 = zext i32 %r6 to i64
%r33 = zext i32 %r6 to i64
%r34 = mul i64 %r32, %r33
%r35 = zext i32 %r8 to i64
%r36 = zext i32 %r8 to i64
%r37 = mul i64 %r35, %r36
%r38 = zext i64 %r31 to i128
%r39 = zext i64 %r34 to i128
%r40 = shl i128 %r39, 64
%r41 = or i128 %r38, %r40
%r42 = zext i128 %r41 to i192
%r43 = zext i64 %r37 to i192
%r44 = shl i192 %r43, 128
%r45 = or i192 %r42, %r44
%r46 = add i192 %r28, %r45
%r47 = bitcast i32* %r1 to i192*
store i192 %r46, i192* %r47
ret void
}
