----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2020 03:32:05 PM
-- Design Name: 
-- Module Name: demux_1_to_64 - Behavioral
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

entity demux_1_to_64 is
port (
    sel : in  std_logic_vector(5 downto 0);
    in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16: out x_reg:= (others=>('0'));
    in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31, in32, in33: out x_reg:= (others=>('0'));
    in34, in35, in36, in37, in38, in39, in40, in41, in42, in43, in44, in45, in46, in47, in48, in49, in50: out x_reg:= (others=>('0'));
    in51, in52, in53, in54, in55, in56, in57, in58, in59, in60, in61, in62, in63: out x_reg:= (others=>('0'));
    input: in x_reg
    );
end demux_1_to_64;

architecture Behavioral of demux_1_to_64 is

begin
  process (sel, input) begin
    if sel = "000000" then
        in0 <= input;
    else
        in0 <= (others=>('0'));
    end if;
    
    if sel = "000001" then
        in1 <= input;   
    else
        in1 <= (others=>('0'));
    end if;  
       
    if sel = "000010" then
        in2 <= input;
    else
        in2 <= (others=>('0'));
    end if;
    
    if sel = "000011" then
        in3 <= input;
    else
        in3 <= (others=>('0'));
    end if;   
    
    if sel = "000100" then
        in4 <= input;
    else
        in4 <= (others=>('0'));
    end if;
    
    if sel = "000101" then
        in5 <= input;
    else
        in5 <= (others=>('0'));
    end if;
    
    if sel = "000110" then
        in6 <= input;
    else
        in6 <= (others=>('0'));
    end if;
    
    if sel = "000111" then
        in7 <= input;
    else
        in7 <= (others=>('0'));
    end if;
    
    if sel = "001000" then   
        in8 <= input;
    else
        in8 <= (others=>('0'));
    end if;
    
    if sel = "001001" then
        in9 <= input;
    else
        in9 <= (others=>('0'));
    end if;
    
    if sel = "001010" then
        in10 <= input;
    else
        in10 <= (others=>('0'));
    end if;
    
    if sel = "001011" then
        in11 <= input;
    else
        in11 <= (others=>('0'));
    end if;
    
    if sel = "001100" then
        in12 <= input;
    else
        in12 <= (others=>('0'));
    end if;
    
    if sel = "001101" then
        in13 <= input;
    else
        in13 <= (others=>('0'));
    end if;
    
    if sel = "001110" then
        in14 <= input;
    else
        in14 <= (others=>('0'));
    end if;
    
    if sel = "001111" then
        in15 <= input;
    else
        in15 <= (others=>('0'));
    end if;
    
    if sel = "010000" then 
        in16 <= input;
    else
        in16 <= (others=>('0'));
    end if;
    
    if sel = "010001" then
        in17 <= input;
    else
        in17 <= (others=>('0'));
    end if;
    
    if sel = "010010" then
        in18 <= input;
    else
        in18 <= (others=>('0'));
    end if;
    
    if sel = "010011" then
        in19 <= input;
    else
        in19 <= (others=>('0'));
    end if;
    
    if sel = "010100" then
        in20 <= input;
    else
        in20 <= (others=>('0'));
    end if;
    
    if sel = "010101" then
        in21 <= input;
    else
        in21 <= (others=>('0'));
    end if;
    
    if sel = "010110" then
        in22 <= input;
    else
        in22 <= (others=>('0'));
    end if;
    
    if sel = "010111" then
        in23 <= input;
    else
        in23 <= (others=>('0'));
    end if;
    
    if sel = "011000" then   
        in24 <= input;
    else
        in24 <= (others=>('0'));
    end if; 
       
    if sel = "011001" then
        in25 <= input;
    else
        in25 <= (others=>('0'));
    end if;
    
    if sel = "011010" then
        in26 <= input;
    else
        in26 <= (others=>('0'));
    end if;
    
    if sel = "011011" then
        in27 <= input;
    else
        in27 <= (others=>('0'));
    end if;
    
    if sel = "011100" then
        in28 <= input;
    else
        in28 <= (others=>('0'));
    end if;
    
    if sel = "011101" then
        in29 <= input;
    else
        in29 <= (others=>('0'));
    end if;
    
    if sel = "011110" then
        in30 <= input;
    else
        in30 <= (others=>('0'));
    end if;
    
    if sel = "011111" then
        in31 <= input;
    else
        in31 <= (others=>('0'));
    end if;
    
    if sel = "100000" then
        in32 <= input;
    else
        in32 <= (others=>('0'));
    end if;
    
    if sel = "100001" then
        in33 <= input;
    else
        in33 <= (others=>('0'));
    end if;
    
    if sel = "100010" then
        in34 <= input;
    else
        in34 <= (others=>('0'));
    end if;
    
    if sel = "100011" then
        in35 <= input;
    else
        in35 <= (others=>('0'));
    end if;
    
    if sel = "100100" then
        in36 <= input;
    else
        in36 <= (others=>('0'));
    end if;
    
    if sel = "100101" then
        in37 <= input;
    else
        in37 <= (others=>('0'));
    end if;
    
    if sel = "100110" then
        in38 <= input;
    else
        in38 <= (others=>('0'));
    end if;
    
    if sel = "100111" then
        in39 <= input;
    else
        in39 <= (others=>('0'));
    end if;
    
    if sel = "101000" then   
        in40 <= input;
    else
        in40 <= (others=>('0'));
    end if; 
      
    if sel = "101001" then
        in41 <= input;
    else
        in41 <= (others=>('0'));
    end if;
    
    if sel = "101010" then
        in42 <= input;
    else
        in42 <= (others=>('0'));
    end if;
    
    if sel = "101011" then
        in43 <= input;
    else
        in43 <= (others=>('0'));
    end if;
    
    if sel = "101100" then
        in44 <= input;
    else
        in44 <= (others=>('0'));
    end if;
    
    if sel = "101101" then
        in45 <= input;
    else
        in45 <= (others=>('0'));
    end if;
    
    if sel = "101110" then
        in46 <= input;
    else
        in46 <= (others=>('0'));
    end if;
    
    if sel = "101111" then
        in47 <= input;
    else
        in47 <= (others=>('0'));
    end if;
    
    if sel = "110000" then 
        in48 <= input;
    else
        in48 <= (others=>('0'));
    end if;
    
    if sel = "110001" then
        in49 <= input;
    else
        in49 <= (others=>('0'));
    end if;
    
    if sel = "110010" then
        in50 <= input;
    else
        in50 <= (others=>('0'));
    end if;
    
    if sel = "110011" then
        in51 <= input;
    else
        in51 <= (others=>('0'));
    end if;
    
    if sel = "110100" then
        in52 <= input;
    else
        in52 <= (others=>('0'));
    end if;
    
    if sel = "110101" then
        in53 <= input;
    else
        in53 <= (others=>('0'));
    end if;
    
    if sel = "110110" then
        in54 <= input;
    else
        in54 <= (others=>('0'));
    end if;
    
    if sel = "110111" then
        in55 <= input;
    else
        in55 <= (others=>('0'));
    end if;
    
    if sel = "111000" then   
        in56 <= input;
    else
        in56 <= (others=>('0'));
    end if;
    
    if sel = "111001" then
        in57 <= input;
    else
        in57 <= (others=>('0'));
    end if;
    
    if sel = "111010" then
        in58 <= input;
    else
        in58 <= (others=>('0'));
    end if;
    
    if sel = "111011" then
        in59 <= input;
    else
        in59 <= (others=>('0'));
    end if;
    
    if sel = "111100" then
        in60 <= input;
    else
        in60 <= (others=>('0'));
    end if;
    
    if sel = "111101" then
        in61 <= input;
    else
        in61 <= (others=>('0'));
    end if;
    
    if sel = "111110" then
        in62 <= input;
    else
        in62 <= (others=>('0'));
    end if;
    
    if sel = "111111" then
        in63 <= input;
    else
        in63 <= (others=>('0'));
    end if; 

  end process;
end Behavioral;
