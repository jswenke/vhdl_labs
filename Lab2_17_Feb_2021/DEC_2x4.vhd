----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2021 09:42:10 PM
-- Design Name: 
-- Module Name: DEC_2x4 - RTL
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DEC_2x4 is
    Port (
         En : in std_logic;
         A  : in  std_logic_vector(1 downto 0);
         B  : out std_logic_vector(3 downto 0)
        );
end DEC_2x4;

architecture RTL of DEC_2x4 is

begin
process (A,En)
begin
    B <= "1111";
    if (En = '1') then
        case A is
            when "00" => B(0) <= '0';
            when "01" => B(1) <= '0';
            when "10" => B(2) <= '0';
            when "11" => B(3) <= '0';
            when others => B <= "1111";
        end case;
    end if;
end process;
end RTL;
