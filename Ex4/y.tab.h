/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TERM = 258,
    ASSIGN_OP = 259,
    ARITH_OP = 260,
    REL_OP = 261,
    ID = 262,
    BOOL_OP = 263,
    EOS = 264,
    IF = 265,
    ELSE = 266,
    WHILE = 267,
    SWITCH = 268,
    CASE = 269,
    DEFAULT = 270,
    BREAK = 271,
    DO = 272,
    MINUS_OP = 273,
    ROUND_LEFT = 274,
    ROUND_RIGHT = 275
  };
#endif
/* Tokens.  */
#define TERM 258
#define ASSIGN_OP 259
#define ARITH_OP 260
#define REL_OP 261
#define ID 262
#define BOOL_OP 263
#define EOS 264
#define IF 265
#define ELSE 266
#define WHILE 267
#define SWITCH 268
#define CASE 269
#define DEFAULT 270
#define BREAK 271
#define DO 272
#define MINUS_OP 273
#define ROUND_LEFT 274
#define ROUND_RIGHT 275

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 14 "4.y" /* yacc.c:1909  */

	int intval;
	float floatval;
	char *str;

#line 100 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
