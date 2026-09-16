@llvm_n2_p = dso_local local_unnamed_addr global i64 9223372036854775809
@ip = internal unnamed_addr constant i32 4294967295
@pStr = private unnamed_addr constant [19 x i8] c"0x8000000000000001\00"
define i8* @llvm_n2_get_prime()
{
%r2 = bitcast [19 x i8] *@pStr to i8*
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
define private i96 @llvm_n2_mulUnit(i32* noalias %r2, i32 %r3) alwaysinline
{
%r4 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 0)
%r5 = trunc i64 %r4 to i32
%r6 = call i32 @extractHigh32(i64 %r4)
%r7 = call i64 @mulPos32x32(i32* %r2, i32 %r3, i32 1)
%r8 = trunc i64 %r7 to i32
%r9 = call i32 @extractHigh32(i64 %r7)
%r10 = zext i32 %r5 to i64
%r11 = zext i32 %r8 to i64
%r12 = shl i64 %r11, 32
%r13 = or i64 %r10, %r12
%r14 = zext i32 %r6 to i64
%r15 = zext i32 %r9 to i64
%r16 = shl i64 %r15, 32
%r17 = or i64 %r14, %r16
%r18 = zext i64 %r13 to i96
%r19 = zext i64 %r17 to i96
%r20 = shl i96 %r19, 32
%r21 = add i96 %r18, %r20
ret i96 %r21
}
define void @llvm_n2_sqrPre(i32* noalias %r1, i32* noalias %r2)
{
%r3 = getelementptr i32, i32* %r2, i32 0
%r4 = load i32, i32* %r3
%r5 = getelementptr i32, i32* %r2, i32 1
%r6 = load i32, i32* %r5
%r7 = zext i32 %r4 to i64
%r8 = zext i32 %r6 to i64
%r9 = mul i64 %r7, %r8
%r10 = zext i64 %r9 to i96
%r11 = add i96 %r10, %r10
%r12 = zext i96 %r11 to i128
%r13 = shl i128 %r12, 32
%r14 = zext i32 %r4 to i64
%r15 = zext i32 %r4 to i64
%r16 = mul i64 %r14, %r15
%r17 = zext i32 %r6 to i64
%r18 = zext i32 %r6 to i64
%r19 = mul i64 %r17, %r18
%r20 = zext i64 %r16 to i128
%r21 = zext i64 %r19 to i128
%r22 = shl i128 %r21, 64
%r23 = or i128 %r20, %r22
%r24 = add i128 %r13, %r23
%r25 = bitcast i32* %r1 to i128*
store i128 %r24, i128* %r25
ret void
}
