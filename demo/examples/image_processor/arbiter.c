////////////////////////////////////////////////////////////////////////////////
//
//  CHIPS-2.0 USER DESIGN
//
//  :Author: Jonathan P Dawson
//  :Date: 17/10/2013
//  :email: chips@jondawson.org.uk
//  :license: MIT
//  :Copyright: Copyright (C) Jonathan P Dawson 2013
//
//  Top level ATLYS design
//
////////////////////////////////////////////////////////////////////////////////

int in1 = input("in1");
int in2 = input("in2");
int out = output("out");

void arbiter(){
    int temp;

    while(1){
        if(ready(in1)){
            while(1){
                temp = fgetc(in1);
                fputc(temp, out);
                if(temp == '\n') break;
            }
        }
        if(ready(in2)){
            while(1){
                temp = fgetc(in2);
                fputc(temp, out);
                if(temp == '\n') break;
            }
        }
    }

}
