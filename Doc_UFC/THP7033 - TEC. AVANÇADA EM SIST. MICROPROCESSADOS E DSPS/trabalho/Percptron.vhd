library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;

entity Perceptron is
    Port (
        clk         : in STD_LOGIC;
        reset       : in STD_LOGIC;
        start       : in STD_LOGIC;
        inputs      : in STD_LOGIC_VECTOR(3 downto 0); 
        output      : out STD_LOGIC;
        done        : out STD_LOGIC;
        debug_sum   : out STD_LOGIC_VECTOR(7 downto 0) 
    );
end Perceptron;

architecture Behavioral of Perceptron is

    constant NUM_INPUTS : integer := 4;
    constant W_BITS     : integer := 2;
    constant SUM_BITS   : integer := 8;

    type WEIGHTS_ARRAY_T is array (0 to NUM_INPUTS - 1) of SIGNED(W_BITS - 1 downto 0);
    constant WEIGHTS : WEIGHTS_ARRAY_T := (
        to_signed(1, W_BITS), 
        to_signed(1, W_BITS), 
        to_signed(1, W_BITS), 
        to_signed(1, W_BITS) 
    );


    constant THRESHOLD : SIGNED(SUM_BITS - 1 downto 0) := to_signed(4, SUM_BITS);
    signal current_state    : integer range 0 to 3 := 0;
    signal internal_done    : STD_LOGIC := '0';
    signal current_input_idx: integer range 0 to NUM_INPUTS := 0;
    signal accumulator      : SIGNED(SUM_BITS - 1 downto 0) := (others => '0');

begin
    done      <= internal_done;
    debug_sum <= std_logic_vector(accumulator);

    process (clk, reset)
    begin
        if reset = '1' then
            current_state     <= 0;
            internal_done     <= '0';
            current_input_idx <= 0;
            accumulator       <= (others => '0');
            output            <= '0';
        elsif rising_edge(clk) then
            case current_state is
                when 0 => 
                    if start = '1' then
                        internal_done     <= '0';
                        current_input_idx <= 0;
                        accumulator       <= (others => '0');
                        current_state     <= 1; 
                    end if;

                when 1 => 
                    if current_input_idx < NUM_INPUTS then
                        if inputs(current_input_idx) = '1' then
                            accumulator <= accumulator + resize(WEIGHTS(current_input_idx), SUM_BITS);
                        end if;
                        current_input_idx <= current_input_idx + 1;
                        current_state     <= 1;
                    else
                        current_state <= 2;
                    end if;

                when 2 =>
                    if accumulator >= THRESHOLD then
                        output <= '1';
                    else
                        output <= '0';
                    end if;
                    current_state <= 3;

                when 3 =>
                    internal_done <= '1';
                    if start = '0' then
                        current_state <= 0;
                    end if;

                when others =>
                    current_state <= 0;
            end case;
        end if;
    end process;

end architecture Behavioral;