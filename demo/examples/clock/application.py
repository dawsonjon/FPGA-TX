from demo.components.server import server
from chips.api.api import *

def application(chip):

    clock = Component(
    """
    #define CLOCKS_PER_SEC 50000000
    #include <stdio.h>
    #include <time.h>
    #include <print.h>
    #include <scan.h>
    stdout = output("rs232_tx");
    stdin = input("rs232_rx");

    void main(){
        tm *t;
        time_t t1;

        //flush characters out of UART
        while(ready(stdin)) fgetc(stdin);

        puts("Year?\n");
        t->tm_year = fscan_udecimal(stdin) - 1900;
        puts("Month?\n");
        t->tm_mon = fscan_udecimal(stdin) - 1;
        puts("Day?\n");
        t->tm_mday = fscan_udecimal(stdin);
        puts("Hour?\n");
        t->tm_hour = fscan_udecimal(stdin);
        puts("Min?\n");
        t->tm_min = fscan_udecimal(stdin);
        t->tm_sec = 0;
        t->tm_isdst = 1;
        set_time(mktime(t));

        while(1){
            t1 = time((time_t*)NULL);
            t = localtime(&t1);
            puts(asctime(t));
            wait_clocks(CLOCKS_PER_SEC);
        }
    }
    """, inline = True)

    clock(
        chip, 
        inputs =  {
            "rs232_rx":chip.inputs["input_rs232_rx"],
        }, 
        outputs = {
            "rs232_tx":chip.outputs["output_rs232_tx"],
        },
        parameters = {})

if __name__ == "__main__":

    chip = Chip("mychip")
    stim = Stimulus(chip, "input_rs232_rx", "int", [ord(i) for i in "hello_world"])
    resp = Response(chip, "output_rs232_tx", "int")
    application(chip)
    chip.simulation_reset()
    while len(resp) < len(stim):
        chip.simulation_step()

    for i in resp:
        print chr(i)

