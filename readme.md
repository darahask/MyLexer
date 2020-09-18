# LexTool Demonstration

This is a Program written to perform lexical analysis of Java Programs, using **lex** tool, a Lexical Analyser generator.

 lex.l, Makefile, and four test java files(for demo usage) are provided.

# Installation of Lex

**Debian:**

`sudo apt-get install flex bison`

**Windows:**

You can find installation procedure [here](https://techapple.net/2014/07/flex-windows-lex-and-yacc-flex-and-bison-installer-for-windows-xp788-1/).

# How to run?

Download all files into same dirctory and go the directory and open terminal and run commands as it is.

**Manual run:**
- `lex lex.l`
- The above command generates `lex.yy.c` file.
- `gcc lex.yy.c -o mylexer`
- `./mylexer test.java`

**Using Makefile:**
- `make`
- `./mylexer test.java`

# Working of Lex

> `lex.l` -> on lex lex.l -> `lex.yy.c` -> on gcc lex.yy.c -o mylexer -> `mylexer`

- This lexer outputs the Symbol table with no repeating symbols, table only has keywords,identifiers,int, float etc. and rest of the symbols which are operators and seperators are displayed seperately. 

# Contributor

`Darahas Kopprapu, CS18B007`
