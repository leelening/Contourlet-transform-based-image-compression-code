function b=antiZscan(a)
%输入一个1*64数组，输出8*8块
%可以采用逻辑判断加循环来解决，但是速度可能会受到影响
%故采用直接对应赋值，以代码的增多来换取速度
b(1,1)=a(1);
b(1,2)=a(2);
b(2,1)=a(3);
b(3,1)=a(4);
b(2,2)=a(5);
b(1,3)=a(6);
b(1,4)=a(7);
b(2,3)=a(8);
b(3,2)=a(9);
b(4,1)=a(10);
b(5,1)=a(11);
b(4,2)=a(12);
b(3,3)=a(13);
b(2,4)=a(14);
b(1,5)=a(15);
b(1,6)=a(16);
b(2,5)=a(17);
b(3,4)=a(18);
b(4,3)=a(19);
b(5,2)=a(20);
b(6,1)=a(21);
b(7,1)=a(22);
b(6,2)=a(23);
b(5,3)=a(24);
b(4,4)=a(25);
b(3,5)=a(26);
b(2,6)=a(27);
b(1,7)=a(28);
b(1,8)=a(29);
b(2,7)=a(30);
b(3,6)=a(31);
b(4,5)=a(32);
b(5,4)=a(33);
b(6,3)=a(34);
b(7,2)=a(35);
b(8,1)=a(36);
b(8,2)=a(37);
b(7,3)=a(38);
b(6,4)=a(39);
b(5,5)=a(40);
b(4,6)=a(41);
b(3,7)=a(42);
b(2,8)=a(43);
b(3,8)=a(44);
b(4,7)=a(45);
b(5,6)=a(46);
b(6,5)=a(47);
b(7,4)=a(48);
b(8,3)=a(49);
b(8,4)=a(50);
b(7,5)=a(51);
b(6,6)=a(52);
b(5,7)=a(53);
b(4,8)=a(54);
b(5,8)=a(55);
b(6,7)=a(56);
b(7,6)=a(57);
b(8,5)=a(58);
b(8,6)=a(59);
b(7,7)=a(60);
b(6,8)=a(61);
b(7,8)=a(62);
b(8,7)=a(63);
b(8,8)=a(64);

