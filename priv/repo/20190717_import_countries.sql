begin;
truncate table countries cascade;
alter sequence countries_id_seq restart;
copy countries from stdin csv header;
id,name
1,Albania
2,Argentina
3,Australia
4,Austria
5,Belarus
6,Belgium
7,Bhutan
8,Bolivia
9,Brazil
10,Bulgaria
11,Cambodia
12,Canada
13,Chile
14,China
15,Colombia
16,Costa Rica
17,Crimea
18,Croatia
19,Cuba
20,Cyprus
21,Czech Republic
22,Denmark
23,Ecuador
24,El Salvador
25,Estonia
26,Finland
27,France
28,Georgia
29,Germany
30,Greece
31,Guatemala
32,Hong Kong
33,Hungary
34,Iceland
35,India
36,Ireland
37,Israel
38,Italy
39,Japan
40,Kazakhstan
41,Latvia
42,Lithuania
43,Malaysia
44,Malta
45,Mexico
46,Moldova
47,Mongolia
48,Montenegro
49,Nepal
50,Netherlands
51,New Zealand
52,Norway
53,Panama
54,Paraguay
55,Peru
56,Philippines
57,Poland
58,Portugal
59,Romania
60,Russia
61,Serbia
62,Singapore
63,Slovakia
64,Slovenia
65,South Africa
66,South Korea
67,Spain
68,Sweden
69,Switzerland
70,Taiwan
71,Thailand
72,Ukraine
73,United Kingdom
74,United States
75,Uruguay
76,Uzbekistan
77,Venezuela
78,Viet Nam
\.
select setval('countries_id_seq', max(id)) from countries;
commit;
