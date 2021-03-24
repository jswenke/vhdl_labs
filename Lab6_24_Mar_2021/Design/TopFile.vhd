----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2021 09:27:54 PM
-- Design Name: 
-- Module Name: TopFile - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use ieee.math_real.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopFile is
    generic (BarrelInputAmount: integer:= 8-1); -- -- there's actually 8 total 
 
  Port ( 
        top_clk         : in std_logic;
        top_input       : in std_logic_vector(BarrelInputAmount downto 0);
        top_output       :out std_logic_vector(BarrelInputAmount downto 0);
        top_count       : in std_logic_vector(integer(ceil(log2(real(BarrelInputAmount+1))))-1 downto 0);
        top_seg_out     : out std_logic_vector(6 downto 0); --seg cathodes(digit lines)
        top_seg_an      : out std_logic_vector(7 downto 0);  --seg anodes(enables)

        top_direction   : in std_logic;
        top_rotation    : in std_logic
  
        );
end TopFile;


-- The goal here is to integrate the shifter with the seven seg displays -- 
architecture Behavioral of TopFile is

component BarrelShifter is
 generic (BarrelInputAmount: integer:= 8-1); 
 Port ( 
    input: in std_logic_vector(BarrelInputAmount downto 0);
    output: out std_logic_vector(BarrelInputAmount downto 0);
    count: in std_logic_vector(integer(ceil(log2(real(BarrelInputAmount+1))))-1 downto 0); 
    direction: in std_logic;
    rotation: in std_logic
    
    
 );
end component BarrelShifter;


component bin_to_bcd is -- Add component
    Port (
            bin     : in std_logic_vector(3 downto 0);
            bcd     : out std_logic_vector(3 downto 0)
         );
end component;

component clock_divider is -- Add Componen
    Port (
            clk : in std_logic;
            clock_out: out std_logic
         );
end component;

component sevseg_controller is -- Add the component
        Port (
                refreshclk      : in std_logic;
                bcd_dgts        : in std_logic_vector(31 downto 0);
                seg_an          : out std_logic_vector(7 downto 0);
                seg_out         : out std_logic_vector(6 downto 0)       
             );
end component;

signal refresh_clock: std_logic;
--signal LED_output: std_logic_vector(BarrelInputAmount downto 0);

signal tmp_out: std_logic_vector(BarrelInputAmount downto 0);

begin

top_output <= tmp_out;

clkdiv_refresh: clock_divider
    port map(
                clk         => top_clk,
                clock_out   => refresh_clock
            );


Barrel_portmap: BarrelShifter
        generic map(BarrelInputAmount => BarrelInputAmount)
        port map (
        input => top_input,
        output => tmp_out,
        count => top_count,
        direction => top_direction,
        rotation => top_rotation   
        );

segcontrol: sevseg_controller
    port map(
                refreshclk      => refresh_clock,

                bcd_dgts(0)     => top_input(0),
                bcd_dgts(1)     => top_input(1),
                bcd_dgts(2)     => top_input(2),
                bcd_dgts(3)     => top_input(3),
                
                bcd_dgts(4)     => top_input(4),
                bcd_dgts(5)     => top_input(5),
                bcd_dgts(6)     => top_input(6),
                bcd_dgts(7)     => top_input(7),
                
                bcd_dgts(8)     => '0',
                bcd_dgts(9)     => '0',
                bcd_dgts(10)    => '0',
                bcd_dgts(11)    => '0',
                
                bcd_dgts(12)    => top_count(0),
                bcd_dgts(13)    => top_count(1),
                bcd_dgts(14)    => top_count(2),
                bcd_dgts(15)    => '0',
                
                bcd_dgts(16)    => '0',
                bcd_dgts(17)    => '0',
                bcd_dgts(18)    => '0',
                bcd_dgts(19)    => '0',
                
                bcd_dgts(20)    => '0',
                bcd_dgts(21)    => '0',
                bcd_dgts(22)    => '0',
                bcd_dgts(23)    => '0',
                
                bcd_dgts(24)    => tmp_out(0),
                bcd_dgts(25)    => tmp_out(1),
                bcd_dgts(26)    => tmp_out(2),
                bcd_dgts(27)    => tmp_out(3),
                
                bcd_dgts(28)    => tmp_out(4),
                bcd_dgts(29)    => tmp_out(5),
                bcd_dgts(30)    => tmp_out(6),
                bcd_dgts(31)    => tmp_out(7),           
             
                seg_an      => top_seg_an,
                seg_out     => top_seg_out
            );    




end Behavioral;
