import 'package:flutter/material.dart';

class Pallet {
  static MaterialColor get primary => const MaterialColor(0xFFEF3C52, {
        900: Color(0xFF720B3E),
        800: Color(0xFF8A1342),
        700: Color(0xFFAC1E49),
        600: Color(0xFFCD2B4E),
        500: Color(0xFFEF3C52),
        400: Color(0xFFF56B6F),
        300: Color(0xFFFA9089),
        200: Color(0xFFFDBDB1),
        100: Color(0xFFFEE1D8),
        50: Color(0xFFFFF0EB),
      });

  static MaterialColor get purple => const MaterialColor(0xff36219e, {
        400: Color(0xff8269ff),
        200: Color(0xffe3deff),
      });

  static MaterialColor get orange => const MaterialColor(0xffffb626, {
        400: Color(0xfffed529),
        200: Color(0xffffeabf),
      });

  static const navColor = Color(0xFFEF3C52);
  static const neutral900 = Color(0xFF1A202C);
  static const neutral800 = Color(0xFF2D3748);
  static const neutral700 = Color(0xFF4A5568);
  static const neutral600 = Color(0xFF718096);
  static const neutral500 = Color(0xFFA0AEC0);
  static const neutral400 = Color(0xFFCBD5E0);
  static const neutral300 = Color(0xFFE2E8F0);
  static const neutral200 = Color(0xFFEDF2F7);
  static const neutral100 = Color(0xFFF7FAFC);
  static const neutralWhite = Color(0xFFFFFFFF);

  static const primary900 = Color(0xFF720B3E);
  static const primary800 = Color(0xFF8A1342);
  static const primary700 = Color(0xFFAC1E49);
  static const primary600 = Color(0xFFCD2B4E);
  static const primary500 = Color(0xFFEF3C52);
  static const primary400 = Color(0xFFF56B6F);
  static const primary300 = Color(0xFFFA9089);
  static const primary200 = Color(0xFFFDBDB1);
  static const primary100 = Color(0xFFFEE1D8);
  static const primary50 = Color(0xFFFFF0EB);

  static const secondary900 = Color(0xFF7A0C14);
  static const secondary800 = Color(0xFF931515);
  static const secondary700 = Color(0xFFB72B21);
  static const secondary600 = Color(0xFFDB4830);
  static const secondary500 = Color(0xFFFF6B42);
  static const secondary400 = Color(0xFFFF9A71);
  static const secondary300 = Color(0xFFFFB68D);
  static const secondary200 = Color(0xFFFFD4B3);
  static const secondary100 = Color(0xFFFFECD9);
  static const secondary50 = Color(0xFFFFF2E5);

  static const danger900 = Color(0xFF6C0539);
  static const danger800 = Color(0xFF931F4F);
  static const danger700 = Color(0xFFB7315C);
  static const danger600 = Color(0xFFDB4869);
  static const danger500 = Color(0xFFFF6378);
  static const danger400 = Color(0xFFFF8A8E);
  static const danger300 = Color(0xFFFFA6A1);
  static const danger200 = Color(0xFFFFC9C0);
  static const danger100 = Color(0xFFFFE7DF);
  static const danger50 = Color(0xFFFFE7DF);

  static const warning900 = Color(0xFF756D0B);
  static const warning800 = Color(0xFF8D8512);
  static const warning700 = Color(0xFFAFA71D);
  static const warning600 = Color(0xFFD1C82A);
  static const warning500 = Color(0xFFF4EB3A);
  static const warning400 = Color(0xFFF8F26A);
  static const warning300 = Color(0xFFFBF788);
  static const warning200 = Color(0xFFFDFBB0);
  static const warning100 = Color(0xFFFEFDD7);
  static const warning50 = Color(0xFFFFFEE8);

  static const info900 = Color(0xFF013A70);
  static const info800 = Color(0xFF025087);
  static const info700 = Color(0xFF0371A8);
  static const info600 = Color(0xFF0596C9);
  static const info500 = Color(0xFF07C0EA);
  static const info400 = Color(0xFF42DFF2);
  static const info300 = Color(0xFF67F3F8);
  static const info200 = Color(0xFF9AFCF8);
  static const info100 = Color(0xFFCCFDF8);
  static const info50 = Color(0xFFE0FFFC);

  static const success900 = Color(0xFF0B694C);
  static const success800 = Color(0xFF137F53);
  static const success700 = Color(0xFF1E9D5D);
  static const success600 = Color(0xFF2CBC65);
  static const success500 = Color(0xFF3DDB6C);
  static const success400 = Color(0xFF6BE984);
  static const success300 = Color(0xFF8AF495);
  static const success200 = Color(0xFFB2FBB3);
  static const success100 = Color(0xFFDCFDD8);
  static const success50 = Color(0xFFECFFEA);
}

/*
COLOR SCHEMA
100% — FF
99% — FC
98% — FA
97% — F7
96% — F5
95% — F2
94% — F0
93% — ED
92% — EB
91% — E8
90% — E6
89% — E3
88% — E0
87% — DE
86% — DB
85% — D9
84% — D6
83% — D4
82% — D1
81% — CF
80% — CC
79% — C9
78% — C7
77% — C4
76% — C2
75% — BF
74% — BD
73% — BA
72% — B8
71% — B5
70% — B3
69% — B0
68% — AD
67% — AB
66% — A8
65% — A6
64% — A3
63% — A1
62% — 9E
61% — 9C
60% — 99
59% — 96
58% — 94
57% — 91
56% — 8F
55% — 8C
54% — 8A
53% — 87
52% — 85
51% — 82
50% — 80
49% — 7D
48% — 7A
47% — 78
46% — 75
45% — 73
44% — 70
43% — 6E
42% — 6B
41% — 69
40% — 66
39% — 63
38% — 61
37% — 5E
36% — 5C
35% — 59
34% — 57
33% — 54
32% — 52
31% — 4F
30% — 4D
29% — 4A
28% — 47
27% — 45
26% — 42
25% — 40
24% — 3D
23% — 3B
22% — 38
21% — 36
20% — 33
19% — 30
18% — 2E
17% — 2B
16% — 29
15% — 26
14% — 24
13% — 21
12% — 1F
11% — 1C
10% — 1A
9% — 17
8% — 14
7% — 12
6% — 0F
5% — 0D
4% — 0A
3% — 08
2% — 05
1% — 03
0% — 00
*/
