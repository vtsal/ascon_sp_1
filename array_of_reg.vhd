----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 01:45:54 PM
-- Design Name: 
-- Module Name: array_of_reg - Behavioral
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
package reg_array is
    type t_Row_Col is array (0 to 4, 0 to 63) of std_logic;
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.reg_array.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity array_of_reg is
--  Port ( );
    port(
        signal clk: in std_logic;
        signal input, enable: in t_Row_Col;
        signal output: out t_Row_Col
    );
end array_of_reg;

architecture Behavioral of array_of_reg is

begin
    GEN_ROW: for i in 0 to 4 generate
        GEN_COL: for j in 0 to 63 generate
           Reg: entity work.Reg_single_bit port map(
                clk =>  clk,
                ena =>  enable(i,j),
                din =>  input(i,j),
                dout => output(i,j)
            );
        end generate GEN_COL;
    end generate GEN_ROW;
end Behavioral;
