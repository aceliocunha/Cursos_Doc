library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
    port (
        clk_50MHz : in  std_logic;
        leds_bin  : out std_logic_vector(3 downto 0); 
        led_max   : out std_logic                      
    );
end contador;

architecture rtl of contador is
    constant DIV_COUNT : integer := 25_000_000;  
    signal clk_div : std_logic := '0';
    signal counter_div : integer range 0 to DIV_COUNT := 0;

    signal count : unsigned(3 downto 0) := (others => '0');
    signal max_reached : std_logic := '0';
begin
    process(clk_50MHz)
    begin
        if rising_edge(clk_50MHz) then
            if counter_div = DIV_COUNT then
                counter_div <= 0;
                clk_div <= not clk_div;
            else
                counter_div <= counter_div + 1;
            end if;
        end if;
    end process;

    process(clk_div)
    begin
        if rising_edge(clk_div) then
            if count = "1111" then
                count <= (others => '0');
                max_reached <= '1';
            else
                count <= count + 1;
                max_reached <= '0';
            end if;
        end if;
    end process;

    leds_bin <= std_logic_vector(count);
    led_max  <= max_reached;

end rtl;