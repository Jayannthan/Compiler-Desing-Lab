/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    INTEGER_LITERAL = 259,         /* INTEGER_LITERAL  */
    PUBLIC = 260,                  /* PUBLIC  */
    CLASS = 261,                   /* CLASS  */
    STATIC = 262,                  /* STATIC  */
    VOID = 263,                    /* VOID  */
    MAIN = 264,                    /* MAIN  */
    STRING = 265,                  /* STRING  */
    INT = 266,                     /* INT  */
    PRINTLN = 267,                 /* PRINTLN  */
    LBRACKET = 268,                /* LBRACKET  */
    LBRACE = 269,                  /* LBRACE  */
    RBRACE = 270,                  /* RBRACE  */
    RBRACKET = 271,                /* RBRACKET  */
    PLUS = 272,                    /* PLUS  */
    EQUALS = 273,                  /* EQUALS  */
    LPAREN = 274,                  /* LPAREN  */
    RPAREN = 275,                  /* RPAREN  */
    SEMICOLON = 276                /* SEMICOLON  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IDENTIFIER 258
#define INTEGER_LITERAL 259
#define PUBLIC 260
#define CLASS 261
#define STATIC 262
#define VOID 263
#define MAIN 264
#define STRING 265
#define INT 266
#define PRINTLN 267
#define LBRACKET 268
#define LBRACE 269
#define RBRACE 270
#define RBRACKET 271
#define PLUS 272
#define EQUALS 273
#define LPAREN 274
#define RPAREN 275
#define SEMICOLON 276

/* Value type.  */


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
