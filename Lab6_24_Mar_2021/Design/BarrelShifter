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

entity BarrelShifter is
    generic (BarrelInputAmount: integer:= 8-1); -- -- there's actually 8 total 
 Port 
 ( 
    input      : in std_logic_vector(BarrelInputAmount downto 0);
    count      : in std_logic_vector(integer(ceil(log2(real(BarrelInputAmount+1))))-1  downto 0); 
    direction  : in std_logic;
    rotation   : in std_logic

    output: out std_logic_vector(BarrelInputAmount downto 0);
    
    
 );
end BarrelShifter;

architecture Behavioral of BarrelShifter is

   -- FUNCTIONS --
function barrel_shifter( -- SHIFT FUNCTION
   din: in std_logic_vector(BarrelInputAmount downto 0);
   dir: in std_logic;
   cnt: in std_logic_vector(integer(ceil(log2(real(BarrelInputAmount+1))))-1 downto 0)) return std_logic_vector is 

begin
   if (dir = '1') then
   return std_logic_vector((SHR(unsigned(din), unsigned(cnt))));
   else
   return std_logic_vector((SHL(unsigned(din), unsigned(cnt))));
   end if;
end barrel_shifter;

function barrel_rotate( -- ROTATE FUNCTION
   din: in std_logic_vector(BarrelInputAmount downto 0);
   dir: in std_logic;
   cnt: in std_logic_vector(integer(ceil(log2(real(BarrelInputAmount+1))))-1 downto 0)) return std_logic_vector is
      
   variable temp1, temp2: std_logic_vector((BarrelInputAmount*2)+1 downto 0);
begin 

   case dir is 

   when '1' => 

      temp1:= din & din;
      temp2:= std_logic_vector(SHR(unsigned(temp1),unsigned(cnt)));
      return temp2(BarrelInputAmount downto 0);

   when others =>
      temp1 := din & din;
      temp2 := std_logic_vector(SHL(unsigned(temp1),unsigned(cnt)));
      return temp2((BarrelInputAmount*2)+1 downto BarrelInputAmount+1);

   end case dir;
   end barrel_rotate;
-- END OF FUNCTIONS -- 

begin

P1: process (input, direction, rotation, count)
begin
   if (rotation = '0') then -- shift only
      output <= barrel_shifter(input, direction, count);
   else -- rotate only
      output <= barrel_rotate(input, direction, count);
   end if;
end process;

end Behavioral;
