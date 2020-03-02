----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2020 11:32:16 AM
-- Design Name: 
-- Module Name: const_add - Behavioral
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

entity const_add is
--  Port ( );
    port(
        rcin: in std_logic_vector(3 downto 0);
        rcin_local : in std_logic_vector(3 downto 0);
        cr : out std_logic_vector(63 downto 0)        
    );
end const_add;

architecture Behavioral of const_add is

begin

    process( rcin, rcin_local) begin
        if(rcin = x"C"  and rcin_local = x"C") then
		      cr <= x"0000_0000_0000_00F0";
		elsif(rcin = x"8"  and rcin_local = x"8") then
		      cr <= x"0000_0000_0000_00b4";
		elsif(rcin = x"6"  and rcin_local = x"6") then
		      cr <= x"0000_0000_0000_0096";
		elsif(rcin = x"C"  and rcin_local = x"B") then
			cr <= x"0000_0000_0000_00e1";
		elsif(rcin = x"C"  and rcin_local = x"A") then
			cr <= x"0000_0000_0000_00d2";
		elsif(rcin = x"C"  and rcin_local = x"9") then
			cr <= x"0000_0000_0000_00c3";
		elsif(rcin = x"C"  and rcin_local = x"8") then
			cr <= x"0000_0000_0000_00b4";
		elsif((rcin = x"C" or rcin = x"8") and rcin_local = x"7" ) then
			cr <= x"0000_0000_0000_00a5";
		elsif((rcin = x"C" or rcin = x"8") and rcin_local = x"6" ) then
			cr <= x"0000_0000_0000_0096";
		elsif((rcin = x"C" or rcin = x"8" or rcin = x"6") and rcin_local = x"5" ) then
			cr <= x"0000_0000_0000_0087";
		elsif((rcin = x"C" or rcin = x"8" or rcin = x"6") and rcin_local = x"4" ) then
		      cr <= x"0000_0000_0000_0078";
		elsif((rcin = x"C" or rcin = x"8" or rcin = x"6") and rcin_local = x"3" ) then
			cr <= x"0000_0000_0000_0069";
		elsif((rcin = x"C" or rcin = x"8" or rcin = x"6") and rcin_local = x"2" ) then
			cr <= x"0000_0000_0000_005a";
		elsif((rcin = x"C" or rcin = x"8" or rcin = x"6") and rcin_local = x"1" ) then
			cr <= x"0000_0000_0000_004b";
		else
		    cr <= x"0000_0000_0000_0000";
		end if;	 		
    end process;


end Behavioral;
