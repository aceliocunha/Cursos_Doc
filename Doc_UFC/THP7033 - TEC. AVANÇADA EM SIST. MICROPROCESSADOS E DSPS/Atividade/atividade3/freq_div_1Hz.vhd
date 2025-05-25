library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity freq_div_1Hz is
    port (
        clk_in : in std_logic;
        clk_out : out std_logic
    );
end freq_div_1Hz;

architecture rtl of freq_div_1Hz is
    constant MAX_COUNT : integer := 25_000_000 - 1; 
    signal counter : integer range 0 to MAX_COUNT := 0;
    signal clk_1Hz : std_logic := '0';
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = MAX_COUNT then
                counter <= 0;
                clk_1Hz <= not clk_1Hz;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_1Hz;

end rtl;