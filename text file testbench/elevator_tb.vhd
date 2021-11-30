LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.elevator_pack.ALL;

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

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset, motor_up, motor_down, move_state : STD_LOGIC;
    SIGNAL come, cf, current_floor : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL switch : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0001";
    SIGNAL PERIOD  : TIME := 50 ns;

BEGIN
    
    clk <= not clk after 5 ns;

    read_test_vector_from_file( PERIOD,
                                reset,
                                cf, 
                                come,
                                SWITCH);
    dut : elevator PORT MAP(clk, reset, come, cf, switch, motor_up, motor_down, current_floor, move_state);
                                


  

END ARCHITECTURE behave;