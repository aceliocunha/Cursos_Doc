--testbench
library ieee;
use ieee.std_logic_1164.all;

entity tb_divisor_freq is
end tb_divisor_freq;

architecture sim of tb_divisor_freq is
  signal clk : std_logic := '0';
  signal led : std_logic;
begin
  uut: entity work.freq_div_05Hz
    port map (
      clk_50MHz => clk,
      led_out => led
    );

  clk_process: process
  begin
    while now < 2 sec loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
    wait;
  end process;
end sim;