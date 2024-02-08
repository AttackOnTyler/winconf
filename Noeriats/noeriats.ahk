; Disable Noeriats for shortcut keys
Loop {
	If GetKeyState("Control")
	or GetKeyState("Alt")
	or GetKeyState("LWin")
	or GetKeyState("RWin") {
		Suspend 1
	} else {
		Suspend 0
	}
	Sleep(50)
}

; QWERTY to Noeriats mapping
1::7
2::5
3::3
4::1
5::9
6::0
7::2
8::4
9::6
0::8
-::q
=::]

q::,
w::.
e::l
r::p
t::[
y::`;
u::h
i::u
o::y
p::v
[::j
]::/

a::n
s::o
d::e
f::r
g::b
h::f
j::i
k::a
l::t
`;::s
'::z

z::'
x::w
;c::c
v::m
b::-
n::=
m::g
,::d
.::k
/::x
