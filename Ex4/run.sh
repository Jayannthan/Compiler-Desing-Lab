lex 4.l
yacc -d 4.y
gcc -w y.tab.c lex.yy.c -lm
./a.out test2.txt
