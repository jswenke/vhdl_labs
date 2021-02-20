----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2021 09:52:54 PM
-- Design Name: 
-- Module Name: N_DEC - RTL
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
use IEEE.math_real.ALL;
--use IEEE.std_logic_arith.All;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity N_DEC is
    generic (WIDTH : integer := 5); 
    Port (
         NDEC_EN  : in std_logic;
         NDEC_IN  : in std_logic_vector(WIDTH-1 downto 0);         
         NDEC_OUT : out std_logic_vector(2**WIDTH-1 downto 0);
         selectLED: out std_logic
        );
end N_DEC;

architecture RTL of N_DEC is

component DEC_2x4 is 
    Port (
         En : in std_logic;
         A  : in  std_logic_vector(1 downto 0);
         B  : out std_logic_vector(3 downto 0)
        );
end component;

signal TmpDec : std_logic_vector(76 downto 0); 				                            -- Make generic

begin

TmpDec (4 downto 0) <= NDEC_IN; 					                                    -- To be worked out

TmpDec (5) <= NDEC_EN;

OUTFOR: for i in integer(ceil(real(WIDTH/2)))-1 downto 0 generate                	    -- Used for determining "columns" of Decoders
INFOR:      for j in 0 to integer(ceil(real(2**WIDTH/4**(i+1))))-1 generate  			-- Used for generation of Decoders in each "column"

            DEC: DEC_2x4 port map                                                       -- Not complete, still need to figure out wire mapping
                (
                En    => TmpDec(WIDTH*j+1),
                A(0)  => TmpDec(WIDTH*(i+1)+2*j),
				A(1)  => TmpDec(WIDTH*(i+1)+2*j+1),
                B(0)  => TmpDec(WIDTH*i+j),
				B(1)  => TmpDec(WIDTH*i+j+1),
				B(2)  => TmpDec(WIDTH*i+j+2),
				B(3)  => TmpDec(WIDTH*i+j+4)
                );
    end generate INFOR;            
end generate OUTFOR;    

NDEC_OUT (2**WIDTH-1 downto 0) <= TmpDec(76 downto 45);

end RTL;