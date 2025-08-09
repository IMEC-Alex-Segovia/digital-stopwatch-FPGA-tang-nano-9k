library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_DECODER is
    Port(
        num : in STD_LOGIC_VECTOR(3 downto 0);
        dsp : out STD_LOGIC_VECTOR(7 downto 0)
    );
end BCD_DECODER;

architecture BCD_DECODER_ARCH of BCD_DECODER is
begin
    process(num)
    begin
        case num is
            when "0000" => dsp <= "00111111";  -- 0
            when "0001" => dsp <= "00000110";  -- 1
            when "0010" => dsp <= "01011011";  -- 2
            when "0011" => dsp <= "01001111";  -- 3
            when "0100" => dsp <= "01100110";  -- 4
            when "0101" => dsp <= "01101101";  -- 5
            when "0110" => dsp <= "01111101";  -- 6
            when "0111" => dsp <= "00000111";  -- 7
            when "1000" => dsp <= "01111111";  -- 8
            when "1001" => dsp <= "01101111";  -- 9
            when others => dsp <= (others => '1');
        end case;
    end process;
end BCD_DECODER_ARCH;
