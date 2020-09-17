%option noyywrap

%{

   int SIZE = 20;

   struct block{
      char  *type;
      char  *symbol;
      struct block *next;
    };

   struct block* hash_table[20];

   int hashFunc(char* symbol){
      unsigned long hash = 5381;
      int c;

      while (c = *symbol++)
        hash = ((hash << 5) + hash) + c;

    return hash%SIZE;
   }

   void insert(char* type, char* symbol, int length){
      int hash = hashFunc(symbol);
      if(hash_table[hash] == NULL){
         struct block* ele = (struct block*) malloc(sizeof(struct block));
         ele->type = type;
         ele->symbol = (char*)malloc(sizeof(char)*(length));
         strcpy(ele->symbol,symbol);
         ele->next = NULL;
         hash_table[hash] = ele;
      }else{
         struct block* head = hash_table[hash];
         while(head->next != NULL){
            if(strcmp(head->symbol,symbol) == 0){
              return;
            }
            head = head->next;
         }
         if(strcmp(head->symbol,symbol) != 0){
            struct block* ele = (struct block*) malloc(sizeof(struct block));
            ele->type = type;
            ele->symbol = (char*)malloc(sizeof(char)*(length));
            strcpy(ele->symbol,symbol);
            ele->next = NULL;
            head->next = ele;
         }
      }
   }

   void printTable(){
      printf("\n================SYMBOL TABLE=====================\n");
      printf("###########TYPE###############SYMBOL###############\n");
      for(int i =0; i< SIZE; i++){
         if(hash_table[i] != NULL){
            struct block* head = hash_table[i];
            while(head != NULL){
               printf("Type:%s,  Symbol:%s\n",head->type,head->symbol);
               head = head->next;
            }
         }
      }
   }

%}

keyword    (abstract|continue|for|new|switch|assert|default|if|package|synchronized|boolean|do|goto|private|this|break|double|implements|protected|throw|byte|else|import|public|throws|case|enum|instanceof|return|transient|catch|extends|int|short|try|char|final|interface|static|void|class|finally|long|strictfp|volatile|const|float|native|super|while)
letter     [A-za-z]
digit      [0-9]
Identifier {letter}({letter}|{digit})*
int        {digit}+
long       {digit}+"L"
float      {digit}+(\.{digit}+)?(e[+-]?{digit}+)?+"f"
double     {digit}+(\.{digit}+)?(e[+-]?{digit}+)?

%%

" "|"\n"              {;} 
("//".*)|("/*".*"*/") {;}
{keyword}             {printf("Keyword:%s\n",yytext);insert("Keyword",yytext,yyleng);}
{int}                 {printf("Integer:%s\n",yytext);insert("int_var",yytext,yyleng);}
{long}                {printf("Long:%s\n",yytext);insert("long_var",yytext,yyleng);}
{float}               {printf("Float:%s\n",yytext);insert("float_var",yytext,yyleng);}
{double}              {printf("Double:%s\n",yytext);insert("double_var",yytext,yyleng);}
"true"|"false"        {printf("boolean:%s\n",yytext);insert("boolean",yytext,yyleng);}
"\'".*"\'"            {printf("Character:%s\n",yytext);insert("char_var",yytext,yyleng);}
"\"".*"\""            {printf("String:%s\n",yytext);insert("string_var",yytext,yyleng);}
"null"                {printf("NullLiteral:%s\n",yytext);insert("nullliteral",yytext,yyleng);}
"("                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
")"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"{"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"}"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
","                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
";"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"."                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"@"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"..."                 {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"::"                  {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"["                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"]"                   {printf("Seperator:%s\n",yytext);insert("Seperator",yytext,yyleng);}
"-"                   {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"+"                   {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"*"                   {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"/"                   {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"%"                   {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"++"                  {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"--"                  {printf("Arithematic:%s\n",yytext);insert("Arithematic",yytext,yyleng);}
"="                   {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"+="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"-="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"*="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"/="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"%="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"&="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"|="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"^="                  {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
">>="                 {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"<<="                 {printf("Assignment:%s\n",yytext);insert("Assignment",yytext,yyleng);}
"=="                  {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
"!="                  {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
">"                   {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
"<"                   {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
"<="                  {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
">="                  {printf("Comparision:%s\n",yytext);insert("Comparision",yytext,yyleng);}
"&&"                  {printf("Logical:%s\n",yytext);insert("Logical",yytext,yyleng);}
"||"                  {printf("Logical:%s\n",yytext);insert("Logical",yytext,yyleng);}
"!"                   {printf("Logical:%s\n",yytext);insert("Logical",yytext,yyleng);}
"&"                   {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
"|"                   {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
"~"                   {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
"^"                   {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
"<<"                  {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
">>"                  {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
">>>"                 {printf("Bitwise:%s\n",yytext);insert("Bitwise",yytext,yyleng);}
{Identifier}          {printf("Identifier: %s\n",yytext);insert("Identifier",yytext,yyleng);}

%%


int main(int argc, char* argv[]){
   FILE *fp = fopen(argv[1],"r");
   if(fp == NULL){
      printf("File not present");
      exit(0);
   }
   yyset_in(fp);
   yylex();
   printTable();
   return 0;
}