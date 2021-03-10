/* Parser for SQL Insert Statement */

%{
    #include <stdio.h>
    #include <stdlib.h>
    int columnCount = 0, valueCount = 0;
%}

%token ID 
%token NUM 
%token INSERT 
%token INTO 
%token VALUES

%left ID NUM
 
%%
S               : ST1';'{    
                            printf("QUERY ACCEPTED");
                            exit(0);
                        }
                ;

ST1             : INSERT INTO table '(' attributeList ')' VALUES '(' valuesList ')' 
                    {
                            if(valueCount != columnCount) {
                                printf("QUERY REJECTED!\nERROR : Mismatching LENGTH of Attributes and Values\n");
                                return 0;
                            }
                    }               
                | INSERT INTO table VALUES '(' valuesList ')' 
                ;

attributeList   :    ID ',' attributeList   {columnCount++;}    
                |    ID                     {columnCount++;}
                ;

valuesList      :    ID ',' valuesList      {valueCount++;}
                |    NUM ',' valuesList     {valueCount++;}
                |    ID                     {valueCount++;}
                |    NUM                    {valueCount++;}
                ;

table           : ID;
%%

int yyerror (const char *str) {
    printf("QUERY REJECTED");
    exit(1);
}

int main() 
{
    printf("Enter the Insert Query:\n");
    yyparse();
}
 
int yywrap() {
    return 1;
}
 

 