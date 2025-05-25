library ieee;
use ieee.std_logic_1164.all;

entity tb_and_gate is
end tb_and_gate;

architecture behavior of tb_and_gate is
  signal a, b, y : std_logic;
begin
  uut: entity work.and_gate
    port map (
      a => a,
      b => b,
      y => y
    );

  stim_proc: process
  begin
    a <= '0'; b <= '0'; wait for 10 ns;
    a <= '0'; b <= '1'; wait for 10 ns;
    a <= '1'; b <= '0'; wait for 10 ns;
    a <= '1'; b <= '1'; wait for 10 ns;
    wait;
  end process;
end behavior;

