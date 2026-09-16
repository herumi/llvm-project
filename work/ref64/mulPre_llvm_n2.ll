@llvm_n2_p = dso_local local_unnamed_addr global i128 170141183460469231731687303715884105729
@ip = internal unnamed_addr constant i64 18446744073709551615
@pStr = private unnamed_addr constant [35 x i8] c"0x80000000000000000000000000000001\00"
define i8* @llvm_n2_get_prime()
{
%r2 = bitcast [35 x i8] *@pStr to i8*
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
define private i192 @llvm_n2_mulUnit(i64* noalias %r2, i64 %r3) alwaysinline
{
%r4 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 0)
%r5 = trunc i128 %r4 to i64
%r6 = call i64 @extractHigh64(i128 %r4)
%r7 = call i128 @mulPos64x64(i64* %r2, i64 %r3, i64 1)
%r8 = trunc i128 %r7 to i64
%r9 = call i64 @extractHigh64(i128 %r7)
%r10 = zext i64 %r5 to i128
%r11 = zext i64 %r8 to i128
%r12 = shl i128 %r11, 64
%r13 = or i128 %r10, %r12
%r14 = zext i64 %r6 to i128
%r15 = zext i64 %r9 to i128
%r16 = shl i128 %r15, 64
%r17 = or i128 %r14, %r16
%r18 = zext i128 %r13 to i192
%r19 = zext i128 %r17 to i192
%r20 = shl i192 %r19, 64
%r21 = add i192 %r18, %r20
ret i192 %r21
}
define void @llvm_n2_sqrPre(i64* noalias %r1, i64* noalias %r2)
{
%r3 = getelementptr i64, i64* %r2, i32 0
%r4 = load i64, i64* %r3
%r5 = getelementptr i64, i64* %r2, i32 1
%r6 = load i64, i64* %r5
%r7 = zext i64 %r4 to i128
%r8 = zext i64 %r6 to i128
%r9 = mul i128 %r7, %r8
%r10 = zext i128 %r9 to i192
%r11 = add i192 %r10, %r10
%r12 = zext i192 %r11 to i256
%r13 = shl i256 %r12, 64
%r14 = zext i64 %r4 to i128
%r15 = zext i64 %r4 to i128
%r16 = mul i128 %r14, %r15
%r17 = zext i64 %r6 to i128
%r18 = zext i64 %r6 to i128
%r19 = mul i128 %r17, %r18
%r20 = zext i128 %r16 to i256
%r21 = zext i128 %r19 to i256
%r22 = shl i256 %r21, 128
%r23 = or i256 %r20, %r22
%r24 = add i256 %r13, %r23
%r25 = bitcast i64* %r1 to i256*
store i256 %r24, i256* %r25
ret void
}
