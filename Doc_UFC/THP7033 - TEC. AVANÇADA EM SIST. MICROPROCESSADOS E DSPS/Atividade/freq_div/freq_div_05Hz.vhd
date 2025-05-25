--1) Escreva um código em VHDL de um divisor de frequência que obedeça às seguintes especificações:
--a. A entidade deverá ter somente uma entrada de 1 bit para o clock (50 MHz ?
--PIN_L1) e uma saída de 1 bit para um dos Leds do Kit.
--b. O Led deverá piscar na frequência de 0,5 Hz, sendo 1s aceso e 1s apagado.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity freq_div_05Hz is
    port (
        clk_50MHz : in std_logic; 
        led_out : out std_logic 
    );
end freq_div_05Hz;

architecture rtl of freq_div_05Hz is
    constant MAX_COUNT : integer := 25_000_000; 
    signal counter : integer range 0 to MAX_COUNT := 0;
    signal toggle_led : std_logic := '0';
begin
    process(clk_50MHz)
    begin
        if rising_edge(clk_50MHz) then
            if counter = MAX_COUNT then
                counter <= 0;
                toggle_led <= not toggle_led;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    led_out <= toggle_led;

end rtl;