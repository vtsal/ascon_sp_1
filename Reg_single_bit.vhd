----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 02:02:13 PM
-- Design Name: 
-- Module Name: Reg_single_bit - Behavioral
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

entity Reg_single_bit is
--  Port ( );
    port    (
                clk : in  std_logic;
                ena : in  std_logic;
                din : in  std_logic;
                dout: out std_logic
             );
end Reg_single_bit;

architecture Behavioral of Reg_single_bit is
	signal qnext:std_logic;
begin
	
reg: 	process(clk)
		begin
			if rising_edge(clk) then 
				if ena ='1' then
					qnext <= din; 
				end if;
			end if; 
		end process;
	  dout<=qnext;
  
end Behavioral;
