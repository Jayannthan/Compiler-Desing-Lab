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
    NUM = 258,
    DTYPE = 259,
    EOS = 260,
    PPD = 261,
    IF = 262,
    WHILE = 263,
    FOR = 264,
    ELSE = 265,
    ID = 266,
    COMPARISON_OP = 267,
    ASSIGN_OP = 268,
    INDE_OP = 269,
    RSHIFT = 270,
    LSHIFT = 271,
    NOT = 272,
    OR = 273,
    AND = 274,
    ARITH_OP = 275,
    NEW = 276,
    THIS = 277,
    CLASS = 278,
    PUBLIC = 279,
    PRIVATE = 280,
    STATIC = 281
  };
#endif
/* Tokens.  */
#define NUM 258
#define DTYPE 259
#define EOS 260
#define PPD 261
#define IF 262
#define WHILE 263
#define FOR 264
#define ELSE 265
#define ID 266
#define COMPARISON_OP 267
#define ASSIGN_OP 268
#define INDE_OP 269
#define RSHIFT 270
#define LSHIFT 271
#define NOT 272
#define OR 273
#define AND 274
#define ARITH_OP 275
#define NEW 276
#define THIS 277
#define CLASS 278
#define PUBLIC 279
#define PRIVATE 280
#define STATIC 281

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
