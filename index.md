# ELEVATOR CONTROLLER FSM IMPLEMENTATION (VHDL)
In this project, I implemented a simple finite state machine of a 4-floor elevator using VHDL. It's a good example to see how you can implement finite state machines in VHDL. There's an extra part in this implementation that uses text file input as testbench.

### DESCRIPTION

FSM of this elevator controller consists of three states: idle, moving, and reset. The idle state is the state in which the elevator stops and evaluate the situation and check pending request (PendingReq) to decide what to do. In this implementation, I assume that the elevator's door closing and opening time are zero and we control it with an input signal called Switch. Moving state is for showing us that the elevator is moving and FSM goes into reset state whenever we want to reset the controller (elevator in floor one and nothing is happening. with no pending requests).


<p align="center">
<img src="https://github.com/mrezaamini/Elevator-controller-FSM/blob/main/assets/elevator.png" alt="4-level elevator" width="350" />
</p>

- come[0..3]: 4-bit input, each floor has it's own button and this signal shows us which floor's button in the building is pushed.
- cf[0..3]: 4-bit input, shows us pushed buttons inside the elevator.
- switch[0..3]: 4-bit input, there is a switch in each floor that turns 1 whenever the elevator reaches to that specific floor.
- motor-up: 1-bit output, 1 when elevator is moving up.
- motor-down: 1-bit output, 1 when elevator is moving down.
- current-floor: in this implementation is 4-bit output that shows which floor is elevator in (for showing it inside the cabin).
- move-state: 1-bit output, 1 when elevator is moving and 0 when it stops.

### TEST
The main test is with a simple testbench that initiates a clock (clk) and changes inputs over time.
In Addition, there's another testbench in the "text file testbench" folder that contains testbench, supporting package, and input text file.
Tests are done with modelSim simulator.

![test](/test.png)

### INPUT TEXT FILE TESTBENCH
First, in the elevator package, I implemented this specific package for getting text files as input for testbench. Then in the testbench, we just initiate the clock and call this procedure.

```vhd

PROCEDURE read_test_vector_from_file (
                    SIGNAL pr : IN  TIME; 
                    SIGNAL r : OUT std_logic;
                    SIGNAL cf : OUT std_logic_vector(3 DOWNTO 0);
                    SIGNAL come : OUT std_logic_vector(3 DOWNTO 0);
                    SIGNAL switch : OUT std_logic_vector(3 DOWNTO 0) ) IS
        TYPE myfile IS FILE OF character;
        FILE fp : myfile;
        VARIABLE c : character;
        VARIABLE current_time : TIME := 3 ns;
        VARIABLE line_number : integer := 1;
    BEGIN
    
        FILE_OPEN(fp, "input.txt", READ_MODE);

       -- ignore line 1
      FOR i IN 0 TO 19 LOOP
       READ(fp, c);  
      END LOOP;

       -- ignore line 2
       FOR i IN 0 TO 19 LOOP
        READ(fp, c);
      END LOOP;       
       
      for col in 0 to 13 loop

            -- Read r
            READ(fp, c);
            IF c = '0' THEN
                r <= TRANSPORT '0' AFTER current_time;
            ELSE
                r <= TRANSPORT '1' AFTER current_time;
            END IF;

            READ(fp, c);
            
            -- Read come
            FOR i IN 0 TO 3 LOOP
                READ(fp, c);   
                IF c = '0' THEN
                    come(3-i) <= TRANSPORT '0' AFTER current_time;
                ELSE
                    come(3-i) <= TRANSPORT '1' AFTER current_time;
                END IF;
            END LOOP;

            READ(fp, c);
            
            -- Read cf
            FOR i IN 0 TO 3 LOOP
                READ(fp, c);            
                IF c = '0' THEN
                    cf(3-i) <= TRANSPORT '0' AFTER current_time;
                ELSE
                    cf(3-i) <= TRANSPORT '1' AFTER current_time;
                END IF;
            END LOOP;

            READ(fp, c);
            
            -- Read switch
            FOR i IN 0 TO 3 LOOP
                READ(fp, c);            
                IF c = '0' THEN
                    switch(3-i) <= TRANSPORT '0' AFTER current_time;
                ELSE
                    switch(3-i) <= TRANSPORT '1' AFTER current_time;
                END IF;
            END LOOP;


            READ(fp, c);
            -- Read carriage return
            READ(fp, c);
            -- Read line feed
            current_time := current_time + pr;
            line_number := line_number + 1;
       END LOOP;
      FILE_CLOSE(fp);
    END read_test_vector_from_file;
    
```
