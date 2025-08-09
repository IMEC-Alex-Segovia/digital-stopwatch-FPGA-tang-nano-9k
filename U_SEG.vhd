library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity U_SEG is
    Port(
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        clk_us : out STD_LOGIC;
        u_seg  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end U_SEG;

architecture U_SEG_ARCH of U_SEG is

    constant MAX_COUNT : integer := 27000000;
    signal conta       : unsigned(24 downto 0) := (others => '0');
    signal conta_s     : unsigned(3 downto 0) := (others => '0');
    signal sal         : STD_LOGIC := '1';

begin
    process(clk, rst)
    begin
        if rst = '0' then
            sal <= '1';
            conta <= (others => '0');
            conta_s <= (others => '0');
        elsif rising_edge(clk) then
            if conta = MAX_COUNT - 1 then
                conta <= (others => '0');
                sal <= not sal;

                if conta_s = "1001" then
                    conta_s <= (others => '0');
                else
                    conta_s <= conta_s + 1;
                end if;
            else
                conta <= conta + 1;
            end if;
        end if;
    end process;

    clk_us <= sal;
    u_seg <= std_logic_vector(conta_s);

end U_SEG_ARCH;