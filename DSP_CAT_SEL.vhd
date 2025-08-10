library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DSP_CAT_SEL is
    Port(
        clk     : in  STD_LOGIC;
        sel     : out STD_LOGIC_VECTOR(1 downto 0)
    );
end DSP_CAT_SEL;

architecture DSP_CAT_SEL_ARCH of DSP_CAT_SEL is
    constant MAX_COUNT : integer := 168750;
    signal conta    : unsigned(17 downto 0) := (others => '0');
    signal conta_c  : unsigned(1 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if conta = MAX_COUNT - 1 then
                conta <= (others => '0');

                if conta_c = "11" then
                    conta_c <= (others => '0');
                else
                    conta_c <= conta_c + 1;
                end if;
            else 
                conta <= conta + 1;
            end if;
        end if;
    end process;

    sel <= std_logic_vector(conta_c);
end DSP_CAT_SEL_ARCH;