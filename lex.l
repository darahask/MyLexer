%option noyywrap

%{
   //Number of rows in table
   int SIZE = 20;

   //Block which stores the info about tokens and their symbol
   struct block{
      char  *type;
      char  *symbol;
      struct block *next;
    };

   //Declaration
   struct block* hash_table[20];

   //Hash function
   int hashFunc(char* symbol){
      unsigned long hash = 5381;
      int c;

      while (c = *symbol++)
        hash = ((hash << 5) + hash) + c;

    return hash%SIZE;
   }

   //Inserting into the Hash Table
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
   //Printing into the table
   void printTable(){
      printf("\n=================SYMBOL TABLE=====================\n");
      printf("==============TYPE============SYMBOL==============\n\n");
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
("//".*)              {;}
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*"+"/"      {;}
{keyword}             {insert("Keyword",yytext,yyleng);}
{int}                 {insert("int_var",yytext,yyleng);}
{long}                {insert("long_var",yytext,yyleng);}
{float}               {insert("float_var",yytext,yyleng);}
{double}              {insert("double_var",yytext,yyleng);}
"true"|"false"        {insert("boolean",yytext,yyleng);}
"\'".*"\'"            {insert("char_var",yytext,yyleng);}
"\"".*"\""            {insert("string_var",yytext,yyleng);}
"null"                {insert("nullliteral",yytext,yyleng);}
"("                   {printf("Seperator:%s\n",yytext);}
")"                   {printf("Seperator:%s\n",yytext);}
"{"                   {printf("Seperator:%s\n",yytext);}
"}"                   {printf("Seperator:%s\n",yytext);}
","                   {printf("Seperator:%s\n",yytext);}
";"                   {printf("Seperator:%s\n",yytext);}
"."                   {printf("Seperator:%s\n",yytext);}
"@"                   {printf("Seperator:%s\n",yytext);}
"..."                 {printf("Seperator:%s\n",yytext);}
"::"                  {printf("Seperator:%s\n",yytext);}
"["                   {printf("Seperator:%s\n",yytext);}
"]"                   {printf("Seperator:%s\n",yytext);}
"-"                   {printf("Arithematic:%s\n",yytext);}
"+"                   {printf("Arithematic:%s\n",yytext);}
"*"                   {printf("Arithematic:%s\n",yytext);}
"/"                   {printf("Arithematic:%s\n",yytext);}
"%"                   {printf("Arithematic:%s\n",yytext);}
"++"                  {printf("Arithematic:%s\n",yytext);}
"--"                  {printf("Arithematic:%s\n",yytext);}
"="                   {printf("Assignment:%s\n",yytext);}
"+="                  {printf("Assignment:%s\n",yytext);}
"-="                  {printf("Assignment:%s\n",yytext);}
"*="                  {printf("Assignment:%s\n",yytext);}
"/="                  {printf("Assignment:%s\n",yytext);}
"%="                  {printf("Assignment:%s\n",yytext);}
"&="                  {printf("Assignment:%s\n",yytext);}
"|="                  {printf("Assignment:%s\n",yytext);}
"^="                  {printf("Assignment:%s\n",yytext);}
">>="                 {printf("Assignment:%s\n",yytext);}
"<<="                 {printf("Assignment:%s\n",yytext);}
"=="                  {printf("Comparision:%s\n",yytext);}
"!="                  {printf("Comparision:%s\n",yytext);}
">"                   {printf("Comparision:%s\n",yytext);}
"<"                   {printf("Comparision:%s\n",yytext);}
"<="                  {printf("Comparision:%s\n",yytext);}
">="                  {printf("Comparision:%s\n",yytext);}
"&&"                  {printf("Logical:%s\n",yytext);}
"||"                  {printf("Logical:%s\n",yytext);}
"!"                   {printf("Logical:%s\n",yytext);}
"&"                   {printf("Bitwise:%s\n",yytext);}
"|"                   {printf("Bitwise:%s\n",yytext);}
"~"                   {printf("Bitwise:%s\n",yytext);}
"^"                   {printf("Bitwise:%s\n",yytext);}
"<<"                  {printf("Bitwise:%s\n",yytext);}
">>"                  {printf("Bitwise:%s\n",yytext);}
">>>"                 {printf("Bitwise:%s\n",yytext);}
{Identifier}          {insert("Identifier",yytext,yyleng);}

%%


int main(int argc, char* argv[]){
   FILE *fp = fopen(argv[1],"r");
   if(fp == NULL){
      printf("File not present");
      exit(0);
   }
   
   yyset_in(fp);
   printf("\n============Extra Symbols==============\n\n");
   yylex();
   printTable();
   return 0;
}