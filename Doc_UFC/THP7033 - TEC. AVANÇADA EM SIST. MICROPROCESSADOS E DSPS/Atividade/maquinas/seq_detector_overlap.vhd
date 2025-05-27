LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY seq_detector_overlap IS
    PORT (
        clk  : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        x    : IN  STD_LOGIC;
        z    : OUT STD_LOGIC  
    );
END ENTITY seq_detector_overlap;

ARCHITECTURE behavioral OF seq_detector_overlap IS

    TYPE state_type IS (S0, S1, S2, S3, S4, S5);
    SIGNAL current_state, next_state : state_type;

BEGIN

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            current_state <= S0;
        ELSIF RISING_EDGE(clk) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    PROCESS (current_state, x)
    BEGIN
        z <= '0';

        CASE current_state IS
            WHEN S0 =>
                IF x = '1' THEN
                    next_state <= S1;
                ELSE
                    next_state <= S0;
                END IF;
            WHEN S1 =>
                IF x = '1' THEN
                    next_state <= S2;
                ELSE
                    next_state <= S0;
                END IF;
            WHEN S2 =>
                IF x = '1' THEN
                    next_state <= S2;
                ELSE
                    next_state <= S3;
                END IF;
            WHEN S3 =>
                IF x = '1' THEN
                    next_state <= S4;
                ELSE
                    next_state <= S0;
                END IF;
            WHEN S4 =>
                IF x = '1' THEN
                    next_state <= S5;
                ELSE
                    next_state <= S0;
                END IF;
            WHEN S5 =>
                z <= '1';
                IF x = '1' THEN
                    next_state <= S2;
                ELSE
                    next_state <= S3;
                END IF;
            WHEN OTHERS =>
                next_state <= S0;
        END CASE;
    END PROCESS;

END ARCHITECTURE behavioral;