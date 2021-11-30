LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb IS
END ENTITY tb;

ARCHITECTURE behave OF tb IS
    COMPONENT elevator IS PORT (
        clk, reset : IN STD_LOGIC;
        come : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cf : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        switch : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        motor_up : OUT STD_LOGIC;
        motor_down : OUT STD_LOGIC;
        current_floor : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        move_state : OUT STD_LOGIC -- zero for stop / one for moving
        );
    END COMPONENT elevator;

    SIGNAL clk, reset, motor_up, motor_down, move_state : STD_LOGIC;
    SIGNAL come, cf, current_floor : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL switch : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0001";
    SIGNAL TEMPSW : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN
    dut : elevator PORT MAP(clk, reset, come, cf, switch, motor_up, motor_down, current_floor, move_state);
    PROCESS BEGIN
        clk <= '1';
        WAIT FOR 5 ns;
        clk <= '0';
        WAIT FOR 5 ns;
    END PROCESS;
    PROCESS BEGIN
        reset <= '1';
        come <= "0000";
        cf <= "0000";
	SWITCH<="0001";
        WAIT FOR 12 ns;
        reset <= '0';
        WAIT FOR 32 ns;
        cf <= "0100";
	WAIT FOR 10 NS;
	SWITCH <= "0000";
		WAIT FOR 32 NS;
		SWITCH <= "0010";
	
	WAIT FOR 32 NS;
	
		SWITCH <= "0000";
		WAIT FOR 32 NS;
		SWITCH <= "0100";
	
        WAIT FOR 500 ns;
        reset <= '1';
        come <= "0000";
        cf <= "0000";
        WAIT FOR 5 ns;
        reset <= '0';
        WAIT FOR 10 ns;
        cf <= "0010";
        WAIT;
    END PROCESS;

  

END ARCHITECTURE behave;