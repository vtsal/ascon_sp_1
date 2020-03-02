----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2020 02:32:57 PM
-- Design Name: 
-- Module Name: mux_64_to_1 - Behavioral
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
package type_pkg is
    type x_reg is array (0 to 4) of std_logic;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.type_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_64_to_1 is
--type x_reg is array (0 to 4) of std_logic_vector(63 downto 0);
--  Port ( );
    port (
    sel : in  std_logic_vector(5 downto 0);
    in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16: in x_reg;
    in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33: in x_reg;
    in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50: in x_reg;
    in51, in52, in53, in54, in55, in56, in57, in58, in59, in60, in61, in62, in63: in x_reg;
    output: out x_reg
    );
end mux_64_to_1;

architecture Behavioral of mux_64_to_1 is

begin
with sel select
    output <=
         in0 when "000000", --0
         in1 when "000001",--1
         in2 when "000010",--2
         in3 when "000011",--3
         in4 when "000100",--4
		 in5 when "000101",
         in6 when "000110",
         in7 when "000111",
         in8 when "001000",
         in9 when "001001", 
         in10 when "001010",
         in11 when "001011",
         in12 when "001100",
         in13 when "001101",
		 in14 when "001110",
         in15 when "001111",
         in16 when "010000",
         in17 when "010001",
         in18 when "010010", 
         in19 when "010011",
         in20 when "010100",
         in21 when "010101",
         in22 when "010110",
		 in23 when "010111",
         in24 when "011000",
         in25 when "011001",
         in26 when "011010",
         in27 when "011011",
         in28 when "011100", 
         in29 when "011101",
         in30 when "011110",
         in31 when "011111",
         in32 when "100000",
		 in33 when "100001",
         in34 when "100010",
         in35 when "100011",
         in36 when "100100",
         in37 when "100101", 
         in38 when "100110",
         in39 when "100111",
         in40 when "101000",
         in41 when "101001",
		 in42 when "101010",
         in43 when "101011",
         in44 when "101100",
         in45 when "101101",
         in46 when "101110", 
         in47 when "101111",
         in48 when "110000",
         in49 when "110001",
         in50 when "110010",
		 in51 when "110011",
         in52 when "110100",
         in53 when "110101",
         in54 when "110110",
         in55 when "110111",
         in56 when "111000",
         in57 when "111001", 
         in58 when "111010",
         in59 when "111011",
         in60 when "111100",
         in61 when "111101",
		 in62 when "111110",
         in63 when "111111",
         in63 when others;

end Behavioral;
