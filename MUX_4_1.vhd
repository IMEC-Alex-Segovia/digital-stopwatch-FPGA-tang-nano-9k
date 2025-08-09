library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4_1 is
    Port(
        I0, I1, I2, I3 : in  STD_LOGIC_VECTOR(3 downto 0);
        sel            : in  STD_LOGIC_VECTOR(1 downto 0);
        O              : out STD_LOGIC_VECTOR(3 downto 0)
    );
end MUX_4_1;

architecture MUX_4_1_ARCH of MUX_4_1 is
begin
    O <= I0 when sel = "00" else
         I1 when sel = "01" else
         I2 when sel = "10" else
         I3;
end MUX_4_1_ARCH;