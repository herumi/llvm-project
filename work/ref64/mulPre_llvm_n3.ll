@llvm_n3_p = dso_local local_unnamed_addr global i192 3138550867693340381917894711603833208051177722232017256449
@ip = internal unnamed_addr constant i64 18446744073709551615
@pStr = private unnamed_addr constant [51 x i8] c"0x800000000000000000000000000000000000000000000001\00"
define i8* @llvm_n3_get_prime()
{
%r2 = bitcast [51 x i8] *@pStr to i8*
ret i8* %r2
}
define private i128 @mul64x64L(i64 %r2, i64 %r3)
{
%r4 = zext i64 %r2 to i128
%r5 = zext i64 %r3 to i128
%r6 = mul i128 %r4, %r5
ret i128 %r6
}
define private i64 @extractHigh64(i128 %r2)
{
%r3 = lshr i128 %r2, 64
%r4 = trunc i128 %r3 to i64
ret i64 %r4
}
define private i128 @mulPos64x64(i64* noalias %r2, i64 %r3, i64 %r4)
{
%r5 = getelementptr i64, i64* %r2, i64 %r4
%r6 = load i64, i64* %r5
%r7 = call i128 @mul64x64L(i64 %r6, i64 %r3)
ret i128 %r7
}
define private i256 @llvm_n3_mulUnit(i64* noalias %r2, i64 %r3) alwaysinline
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 2)
%r11 = trunc i128 %r10 to i64
%r12 = call i64 @extractHigh64(i128 %r10)
%r13 = zext i64 %r5 to i128
%r14 = zext i64 %r8 to i128
%r15 = shl i128 %r14, 64
%r16 = or i128 %r13, %r15
%r17 = zext i128 %r16 to i192
%r18 = zext i64 %r11 to i192
%r19 = shl i192 %r18, 128
%r20 = or i192 %r17, %r19
%r21 = zext i64 %r6 to i128
%r22 = zext i64 %r9 to i128
%r23 = shl i128 %r22, 64
%r24 = or i128 %r21, %r23
%r25 = zext i128 %r24 to i192
%r26 = zext i64 %r12 to i192
%r27 = shl i192 %r26, 128
%r28 = or i192 %r25, %r27
%r29 = zext i192 %r20 to i256
%r30 = zext i192 %r28 to i256
%r31 = shl i256 %r30, 64
%r32 = add i256 %r29, %r31
ret i256 %r32
}
define void @llvm_n3_sqrPre(i64* noalias %r1, i64* noalias %r2)
{
%r3 = getelementptr i64, i64* %r2, i32 0
%r4 = load i64, i64* %r3
%r5 = getelementptr i64, i64* %r2, i32 1
%r6 = load i64, i64* %r5
%r7 = getelementptr i64, i64* %r2, i32 2
%r8 = load i64, i64* %r7
%r9 = zext i64 %r4 to i128
%r10 = zext i64 %r8 to i128
%r11 = mul i128 %r9, %r10
%r12 = zext i64 %r4 to i128
%r13 = zext i64 %r6 to i128
%r14 = mul i128 %r12, %r13
%r15 = zext i64 %r6 to i128
%r16 = zext i64 %r8 to i128
%r17 = mul i128 %r15, %r16
%r18 = zext i128 %r14 to i256
%r19 = zext i128 %r17 to i256
%r20 = shl i256 %r19, 128
%r21 = or i256 %r18, %r20
%r22 = zext i128 %r11 to i256
%r23 = shl i256 %r22, 64
%r24 = add i256 %r23, %r21
%r25 = zext i256 %r24 to i320
%r26 = add i320 %r25, %r25
%r27 = zext i320 %r26 to i384
%r28 = shl i384 %r27, 64
%r29 = zext i64 %r4 to i128
%r30 = zext i64 %r4 to i128
%r31 = mul i128 %r29, %r30
%r32 = zext i64 %r6 to i128
%r33 = zext i64 %r6 to i128
%r34 = mul i128 %r32, %r33
%r35 = zext i64 %r8 to i128
%r36 = zext i64 %r8 to i128
%r37 = mul i128 %r35, %r36
%r38 = zext i128 %r31 to i256
%r39 = zext i128 %r34 to i256
%r40 = shl i256 %r39, 128
%r41 = or i256 %r38, %r40
%r42 = zext i256 %r41 to i384
%r43 = zext i128 %r37 to i384
%r44 = shl i384 %r43, 256
%r45 = or i384 %r42, %r44
%r46 = add i384 %r28, %r45
%r47 = bitcast i64* %r1 to i384*
store i384 %r46, i384* %r47
ret void
}
