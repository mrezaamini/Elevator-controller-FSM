LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY elevator IS PORT (
    clk, reset : IN STD_LOGIC;
    come : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    cf : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    switch : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    motor_up : OUT STD_LOGIC;
    motor_down : OUT STD_LOGIC;
    current_floor : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    move_state : OUT STD_LOGIC); -- zero for stop / one for moving
END ENTITY;

ARCHITECTURE synth OF elevator IS 
    TYPE statetype IS (idle, moving, RESETST);
    SIGNAL state, nextstate : statetype;
    SIGNAL pendingReq : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL cFloor : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL direction : STD_LOGIC; -- 1 FOR MOVING UP
    SIGNAL COUNTER : STD_LOGIC_VECTOR(3 DOWNTO 0); --MSB IS FLOOR 4 > LSB IS FLOOR 1

BEGIN
        --pendingReq <= pendingReq OR come OR cf;
        current_floor <= cFloor;
    --state REGISTER
    PROCESS (clk, reset) BEGIN
        IF reset = '1' THEN
            state <= resetst;
        ELSIF rising_edge(clk) THEN
            state <= nextstate;
        END IF;
    END PROCESS;
    --NEXT state logic
    PROCESS (state,cf,come,switch, RESET, cFloor, counter) BEGIN
        CASE state IS
            WHEN idle =>
                move_state <= '0';
		
                
                IF (cFloor and pendingReq) = cFloor THEN
		    pendingReq <= (pendingReq and (not cFloor));
                    nextstate <= idle;
		    motor_up<='0';
	 	    motor_down<='0';
		ELSIF PENDINGREQ = "0000" THen
		     pendingReq <= pendingReq or cf or come;
		     NEXTSTATE<= IDLE;
		     motor_up<='0';
	 	     motor_down<='0';
                ELSE 
		    pendingReq <= pendingReq or cf or come;
                    IF (counter AND pendingReq) = counter THEN
                        nextstate <= moving;
                        motor_up <= direction;
                        motor_down <= (NOT direction);
                    ELSE	
			nextstate <= idle;
			motor_up<='0';
	 	  	motor_down<='0';
                        IF COUNTER = "0001" THEN
                            DIRECTION <= '1';
                            counter <= "0010";
                        ELSIF COUNTER = "1000" THEN
                            DIRECTION <= '0';
                            counter <= "0100";
			ELSE
                            IF direction = '1' THEN -- moving up
                                counter <= counter (2 DOWNTO 0) & '0';
                            ELSIF direction ='0' THEN -- moving down
                                counter <= '0' & counter (3 DOWNTO 1);
                            END IF;
                      

                        END IF;
                    END IF;
                END IF;
--------------------------------------------------------------------------------------------
            WHEN moving =>
                move_state <= '1';
                IF switch = "0000" THEN
                    nextstate <= moving;
		    pendingReq <= pendingReq OR come OR cf;
                ELSE
                    nextstate <= idle;
                    cFloor <= switch;
                    pendingReq <= (pendingReq AND (NOT switch) )OR (come OR cf);
                END IF;
---------------------------------------------------------------------------------------------
	   WHEN RESETST =>
	    motor_up <= '0';
   	    motor_down <= '0';
            move_state <= '0';
	    cFloor <= "0001"; 
            COUNTER <= "0001";
            DIRECTION <= '1';
		pendingReq <= cf or come;
	    	if reset='0' then nextstate<=idle;
		else nextstate<=resetst;
		end if;
            WHEN OTHERS =>
                nextstate <= idle;
        END CASE;
    END PROCESS;
 
END;