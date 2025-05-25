LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY aula1 IS
    PORT (
        a, b : IN STD_LOGIC;
        y : OUT STD_LOGIC

    );
END aula1;

ARCHITECTURE rtl OF aula1 IS
BEGIN
    y <= a AND b;
END rtl;
