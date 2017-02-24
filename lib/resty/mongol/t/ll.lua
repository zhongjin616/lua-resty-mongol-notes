-- Test suits for ll.lua

local assert = assert
local unpack = unpack
local floor = math.floor
local strbyte , strchar = string.byte , string.char

local ll = { }

-- le means 'little-endian'
-- @s 无符号整型二进制字节串
-- 二进制原码 0000 0000 0000 0000 0000 0000 0011 0010 ==> 50
local le_uint_to_num = function ( s , i , j )
	i , j = i or 1 , j or #s
	local b = { strbyte ( s , i , j ) }
	local n = 0
	for i=#b , 1 , -1 do
		n = n*2^8 + b [ i ]
	end
	return n
end
print("\n==>>1. testing le_uint_to_num()")
print("       generate number 1025 binary string")
-- '\1\4'会被解析为二进制值, 这可以用来构造你想要的字符串. 在字符串中,排在后边的字符属于高位
-- 而linux是little-endian系统, 所以在内存中，'\4'所在地址比'\1'的高
-- <----高----(内存地址)-----低---
--       0000 0100, 0000 0001  ==> 这两个字节合并在一起,解析为number，就是1025
local result = le_uint_to_num('\1\4')
print("       calculate result: ", result)
print("       equals to 1025: ", result==1025)


-- be means 'big-endian'
local be_uint_to_num = function ( s , i , j )
	i , j = i or 1 , j or #s
	local b = { strbyte ( s , i , j ) }
	local n = 0
	for i=1 , #b do
		n = n*2^8 + b [ i ]
	end
	return n
end
print("\n==>>2. testing be_uint_to_num()")
print("       generate number 1025 binary string")
local result = be_uint_to_num('\4\1')
print("       calculate result: ", result)
print("       equals to 1025: ", result==1025)


-- @s 有符号整型二进制补码字节串
-- 二进制原码 1000 0000 0000 0000 0000 0000 0011 0010 ==> -50
-- 二进制反码 1111 1111 1111 1111 1111 1111 1100 1101 ==> -50
-- 二进制补码 1111 1111 1111 1111 1111 1111 1100 1110 ==> -50
local le_int_to_num = function ( s , i , j )
	i , j = i or 1 , j or #s
	local n = le_uint_to_num ( s , i , j )
	local overflow = 2^(8*(j-i) + 7)
	if n > overflow then
        -- 选取最小公模数: 2*overflow
        -- 负数真值  =  其补码的二进制形式值 - 最小公模数(想象360度的圆， 12小时的钟)
        -- (0-真值) = 0+补码形式值(看作无符号数，即符号参与运算，不然使用补码就没有意义) - 最小公模
		n = n - 2*overflow
	end
	return n
end
-- 二进制补码 1100 1110 ==> -50
-- 无符号二进制原码 1100 1110 ==> 206
-- 二进制原码 1000 0010 ==> -2
-- 二进制反码 1111 1101 ==> -2
-- 二进制补码 1111 1110 ==> -2
-- 无符号二进制原码 1111 1110 ==> 254
print("\n==>>3. testing le_int_to_num()")
print("       generate number -50's complement-number binary string")
local result = le_int_to_num(string.char(206))
print("       calculate result: ", result)
print("       equals to -50: ", result==-50)
print("       generate number -2's complement-number binary string")
local result = le_int_to_num(string.char(254))
print("       calculate result: ", result)
print("       equals to -2: ", result==-2)

