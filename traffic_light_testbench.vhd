library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;

entity trafic_light_tb is
end trafic_light_tb;

architecture Behavioral of trafic_light_tb is

    -- DUT (Device Under Test) signals
    signal clk_tb : bit := '0';
    signal pa_tb  : bit := '0';
    signal pb_tb  : bit := '0';
    signal Gn_tb, Yn_tb, Rn_tb : bit;
    signal Gw_tb, Yw_tb, Rw_tb : bit;
    signal Pn_tb, Pw_tb        : bit;

    -- Instantiate the DUT
    component trafic_light
        port(
            clk       : in  bit;
            pa, pb    : in  bit;
            Gn, Yn, Rn,
            Gw, Yw, Rw,
            Pn, Pw    : inout bit
        );
    end component;

begin

    uut: trafic_light
        port map(
            clk => clk_tb,
            pa  => pa_tb,
            pb  => pb_tb,
            Gn  => Gn_tb,
            Yn  => Yn_tb,
            Rn  => Rn_tb,
            Gw  => Gw_tb,
            Yw  => Yw_tb,
            Rw  => Rw_tb,
            Pn  => Pn_tb,
            Pw  => Pw_tb
        );

    -- Clock generation
    clk_process: process
    begin
        while true loop
            clk_tb <= '0';
            wait for 5 ns;
            clk_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    stim_process: process
    begin
        -- Initial wait
        wait for 20 ns;

        -- Normal cycle (no pedestrian button)
        wait for 200 ns;

        -- Simulate pedestrian north button
        pa_tb <= '1';
        wait for 20 ns;
        pa_tb <= '0';
        wait for 200 ns;

        -- Simulate pedestrian west button
        pb_tb <= '1';
        wait for 20 ns;
        pb_tb <= '0';
        wait for 200 ns;

        -- Multiple button presses
        pa_tb <= '1';
        pb_tb <= '1';
        wait for 20 ns;
        pa_tb <= '0';
        pb_tb <= '0';
        wait for 200 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
