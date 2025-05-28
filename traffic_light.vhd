

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trafic_light is
    port(
        clk       : in  bit;
        pa, pb    : in  bit;
        Gn, Yn, Rn,
        Gw, Yw, Rw,
        Pn, Pw    : inout bit
    );
end trafic_light;

architecture Behavioral of trafic_light is
    signal state, nextstate : integer range 0 to 11;
begin

    -- Combinational process
    process(state, pa, pb)
    begin
        -- Reset all lights by default
        Gn <= '0'; Yn <= '0'; Rn <= '0';
        Gw <= '0'; Yw <= '0'; Rw <= '0';
        Pn <= '0'; Pw <= '0';
        
        case state is
            when 0 to 3 =>
                Gn <= '1'; Rw <= '1';
                nextstate <= state + 1;

            when 4 =>
                if pa = '1' then 
                    Pn <= '1'; Rn <= '1'; Rw <= '1';
                    nextstate <= 4; -- stay in 4 while pa is high
                else 
                    nextstate <= 5;
                end if;

            when 5 =>
                Gn <= '1'; Yw <= '1';
                nextstate <= 6;

            when 6 to 9 =>
                Gw <= '1'; Rn <= '1';
                nextstate <= state + 1;

            when 10 =>
                if pb = '1' then 
                    Pw <= '1'; Rw <= '1'; Rn <= '1';
                    nextstate <= 10; -- stay in 10 while pb is high
                else 
                    nextstate <= 11;
                end if;

            when 11 =>
                Gw <= '1'; Rn <= '1';
                nextstate <= 0;

            when others =>
                nextstate <= 0;
        end case;
    end process;

    -- Clocked process
    process(clk)
    begin
        if clk'event and clk = '1' then
            state <= nextstate;
        end if;
    end process;

end Behavioral;
