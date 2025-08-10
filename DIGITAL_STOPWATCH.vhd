library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIG_STOPWATCH is
    Port(
        MCLK : in STD_LOGIC;
        RST  : in STD_LOGIC;
        STP  : in STD_LOGIC;
        DSP  : out STD_LOGIC_VECTOR(7 downto 0);
        CAT  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end DIG_STOPWATCH;

architecture DIG_STOPWATCH_ARCH of DIG_STOPWATCH is

    component U_SEG is
        Port(
            clk    : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            stp    : in  STD_LOGIC;
            clk_us : out STD_LOGIC;
            u_seg  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component D_SEG is
        Port(
            clk_us : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            clk_ds : out STD_LOGIC;
            d_seg  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component U_MIN is
        Port(
            clk_ds : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            clk_um : out STD_LOGIC;
            u_min  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component D_MIN is
        Port(
            clk_um : in  STD_LOGIC;
            rst    : in  STD_LOGIC;
            d_min  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component DSP_CAT_SEL is
        Port(
            clk : in  STD_LOGIC;
            sel : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    component MUX_4_1 is
        Port(
            I0, I1, I2, I3 : in  STD_LOGIC_VECTOR(3 downto 0);
            sel            : in  STD_LOGIC_VECTOR(1 downto 0);
            O              : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component BCD_DECODER is
        Port(
            num : in  STD_LOGIC_VECTOR(3 downto 0);
            dsp : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal u_seg_s, d_seg_s, u_min_s, d_min_s, num : STD_LOGIC_VECTOR(3 downto 0);
    signal sel : STD_LOGIC_VECTOR(1 downto 0);
    signal clk_us, clk_ds, clk_um : STD_LOGIC;

    constant CAT0 : STD_LOGIC_VECTOR(3 downto 0) := "1110";
    constant CAT1 : STD_LOGIC_VECTOR(3 downto 0) := "1101";
    constant CAT2 : STD_LOGIC_VECTOR(3 downto 0) := "1011";
    constant CAT3 : STD_LOGIC_VECTOR(3 downto 0) := "0111";

begin

    U0 : U_SEG port map(clk => MCLK, rst => RST, stp => STP, u_seg => u_seg_s, clk_us => clk_us);
    U1 : D_SEG port map(clk_us => clk_us, rst => RST, d_seg => d_seg_s, clk_ds => clk_ds);
    U2 : U_MIN port map(clk_ds => clk_ds, rst => RST, u_min => u_min_s, clk_um => clk_um);
    U3 : D_MIN port map(clk_um => clk_um, rst => RST, d_min => d_min_s);
    U4 : DSP_CAT_SEL port map(clk => MCLK, sel => sel);
    U5 : MUX_4_1 port map(I0 => CAT0, I1 => CAT1, I2 => CAT2, I3 => CAT3, sel => sel, O => CAT);
    U6 : MUX_4_1 port map(I0 => u_seg_s, I1 => d_seg_s, I2 => u_min_s, I3 => d_min_s, sel => sel, O => num);
    U7 : BCD_DECODER port map(num => num, dsp => DSP);

end DIG_STOPWATCH_ARCH;