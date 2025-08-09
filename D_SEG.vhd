library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_SEG is
    Port(
        clk_us : in  STD_LOGIC;
        clk_ds : out STD_LOGIC;
        d_seg  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end D_SEG;

architecture D_SEG_ARCH of D_SEG is

    constant MAX_COUNT : integer :=  5;
    signal conta    : unsigned(3 downto 0) := (others => '0');
    signal conta_s  : unsigned(3 downto 0) := (others => '0');
    signal sal      : STD_LOGIC := '1';

begin
    process(clk_us)
    begin
        if rising_edge(clk_us) then
            if conta = MAX_COUNT - 1 then
                conta <= (others => '0');
                sal <= not sal;

                if conta_s = "0101" then
                    conta_s <= (others => '0');
                else
                    conta_s <= conta_s + 1;
                end if;
            else
                conta <= conta + 1;
            end if;
        end if;
    end process;

    clk_ds <= sal;
    d_seg <= std_logic_vector(conta_s);
end D_SEG_ARCH;