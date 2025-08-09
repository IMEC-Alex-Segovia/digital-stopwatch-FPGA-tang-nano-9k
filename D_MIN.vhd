library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_MIN is
    Port(
        clk_um : in  STD_LOGIC;
        d_min  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end D_MIN;

architecture D_MIN_ARCH of D_MIN is
    constant MAX_COUNT : integer := 5;
    signal conta    : unsigned(3 downto 0) := (others => '0');
    signal conta_m  : unsigned(3 downto 0) := (others => '0');
begin
    process(clk_um)
    begin
        if rising_edge(clk_um) then
            if conta = MAX_COUNT - 1 then
                conta <= (others => '0');
                if conta_m = "0101" then
                    conta_m <= (others => '0');
                else
                    conta_m <= conta_m + 1;
                end if;
            else
                conta <= conta + 1;
            end if;
        end if;
    end process;

    d_min <= std_logic_vector(conta_m);
end D_MIN_ARCH;