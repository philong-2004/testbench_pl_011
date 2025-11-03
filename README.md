# testbench_pl_011
To execute the code, please follow the steps below.
Please move to sim/Makefile -> Change the path to the library file (Line 9, 10)
Then,
1. Open terminal
2. Move to directory sim
3. use command make + ...
   - make clean: removing all file *.ini *.log *.wlf vsim.dbg after compiling
   - make compile: compling all code
   - make run: simulating code on console log
   - make all : make compile + make run
   - make wave: start simlutaing waveform on QueteSim
-----------------------------------------------------------------
Description of Project's Directories:
1. rtl: interface of design file
2. sequence: sequence file
3. sim: setup to compile and simulate code
4. tb: testbench of design
5. SSP_VIP:
     - agent
     - driver
     - environment
     - interface
     - monitor
     - scoreboard
     - sequencer
     - transaction
6. testcase: testcase to call run_test in testbench of design
-----------------------------------------------------------------
Thank you very much for your reviewing of my task 
