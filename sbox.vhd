----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2020 10:37:45 PM
-- Design Name: 
-- Module Name: sbox - Behavioral
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
use work.type_pkg.ALL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sbox is
--  Port ( );
    port(
    input: in x_reg;
    output: out x_reg
    );
end sbox;

architecture Behavioral of sbox is

begin
	
	output(0) <= (input(1) and (not( input(0) xor input(4)))) xor (not(input(1)) and (input(1) xor input(2))) xor input(3) xor input(4) xor input(0) xor input(4);--------expression------------
	output(1) <= (input(0) xor input(4)) xor (not(input(1)) and (input(1) xor input(2))) xor input(1) xor (input(3) and not(input(1) xor input(2))) ;--------expression------------
	output(2) <= not( input(1) xor input(2) xor (not(input(3)) and (input(3) xor input(4)) ));--------expression------------
	output(3) <= (input(1) xor input(2) xor (not(input(3)) and (input(3) xor input(4)))) xor input(3) xor ((not(input(3) xor input(4))) and (input(0) xor input(4)));--------expression------------
	output(4) <= (input(3) xor input(4)) xor (input(1) and (not(input(0) xor input(4)))) ;--------expression------------

end Behavioral;
