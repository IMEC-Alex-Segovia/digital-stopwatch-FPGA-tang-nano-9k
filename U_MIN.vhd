library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity U_MIN is
    Port(
        clk_ds  : in  STD_LOGIC;
        clk_um  : out STD_LOGIC;
        u_min   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end U_MIN;

architecture U_MIN_ARCH of U_MIN is

    constant MAX_COUNT : integer := 3;
    signal conta    : unsigned(2 downto 0) := (others => '0');
    signal conta_m  : unsigned(3 downto 0) := (others => '0');
    signal sal      : STD_LOGIC := '1';

begin
    process(clk_ds)
    begin
        if rising_edge(clk_ds) then
            if conta = MAX_COUNT - 1 then
                conta <= (others => '0');
                sal <= not sal;

                if conta_m = "1001" then
                    conta_m <= (others => '0');
                else
                    conta_m <= conta_m + 1;
                end if;
            else
                conta <= conta + 1;
            end if;
        end if;
    end process;

    clk_um <= sal;
    u_min <= std_logic_vector(conta_m);
end U_MIN_ARCH;