# INTRODUCTION

This MongoDB driver for lua implement "[MongoDB Wire Protocol](https://docs.mongodb.com/v3.2/reference/mongodb-wire-protocol/)"

## BSON数据结构

- [BSON规范](http://bsonspec.org/spec.html)

## 数值的存储方式 | 原码,反码,补码

- [原码,反码,补码](https://www.cnblogs.com/zhangziqiu/archive/2011/03/30/ComputerCode.html)

- [进制转换工具](http://tool.oschina.net/hexconvert/)

## 负数与其补码的二进制形式值关系

[补码(two's complement)](http://www.99cankao.com/numbers/twos-complement.php)

1. 在计算机系统中，数值一律用补码来表示(存储). 主要原因：
  - 使用补码，可以将符号位和其它位统一处理;
  - 同时，减法也可按加法来处理。因为,两个用补码表示的数相加时,如果最高位(符号位)有进位,则进位被舍弃.

2. 补码与原码的转换过程几乎是相同的. 例如:

```
  1111 1111 (最小公模)                255
− 0101 1111                         −  95
=========== (取反操作)               =====
  1010 0000  (反码ones' complement)   160
+         1                          +  1
=========== (加1)                    =====
  1010 0001  (补码two's complement)   161
```

## Big-Endian VS little-endian

- [大端与小端](http://www.bysocket.com/?p=615)

