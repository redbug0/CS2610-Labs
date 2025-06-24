.data
a: .dword 0x1234567887654321
b: .dword 0x8765432112345678
result: .dword 0, 0

.text
.global main

main:


la a1, a
la a2, b

ld a1,0(a1)
ld a2,0(a2)


mul t0, a1, a2
mulhu t1, a1, a2


la a3, result

sd t0, 0(a3)
sd t1, 8(a3)

ret
