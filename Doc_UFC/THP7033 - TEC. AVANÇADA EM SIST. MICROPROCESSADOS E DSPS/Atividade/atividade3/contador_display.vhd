library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_display is
    port (
        clk_1Hz : in std_logic;
        out0, out1, out2, out3 : out std_logic_vector(6 downto 0)
    );
end contador_display;

architecture rtl of contador_display is
    signal count : integer range 0 to 20 := 0;

    function to_7seg(n : integer) return std_logic_vector is
        variable seg : std_logic_vector(6 downto 0);
    begin
        case n is
            when 0 => seg := "1000000";
            when 1 => seg := "1111001";
            when 2 => seg := "0100100";
            when 3 => seg := "0110000";
            when 4 => seg := "0011001";
            when 5 => seg := "0010010";
            when 6 => seg := "0000010";
            when 7 => seg := "1111000";
            when 8 => seg := "0000000";
            when 9 => seg := "0010000";
            when others => seg := "1111111";
        end case;
        return seg;
    end;

    signal d0, d1 : integer range 0 to 9;
begin
    process(clk_1Hz)
    begin
        if rising_edge(clk_1Hz) then
            if count = 20 then
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    d0 <= count mod 10;
    d1 <= count / 10;

    out0 <= to_7seg(d0);
    out1 <= to_7seg(d1);
    out2 <= "1111111";
    out3 <= "1111111";

end rtl;