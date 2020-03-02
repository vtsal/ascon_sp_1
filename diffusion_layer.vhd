----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2020 09:58:06 PM
-- Design Name: 
-- Module Name: diffusion_layer - Behavioral
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

entity diffusion_layer is
--  Port ( );
    port(
    signal rst, clk: in std_logic;
    signal x0,x1,x2,x3,x4: in std_logic_vector(63 downto 0);
    signal x0_diff,x1_diff,x2_diff,x3_diff,x4_diff: out std_logic_vector(63 downto 0);
    signal sel: in std_logic_vector(2 downto 0)
    );
end diffusion_layer;

architecture Behavioral of diffusion_layer is
    signal x0_diff_q,x1_diff_q,x2_diff_q,x3_diff_q,x4_diff_q: std_logic_vector(63 downto 0):= x"0000_0000_0000_0000";    			
    signal set_x0,set_x1,set_x2,set_x3,set_x4, rst_diff_reg: std_logic := '0';
    type diff_state is (idle, state_set_x0, state_set_x1, state_set_x2, state_set_x3, state_set_x4);
    signal state, next_state: diff_state := idle;
begin
    x0_diff <= x0_diff_q;
    x1_diff <= x1_diff_q;
    x2_diff <= x2_diff_q;
    x3_diff <= x3_diff_q;
    x4_diff <= x4_diff_q;
  
    
    process(sel) begin
        set_x0 <= '0';
        set_x1 <= '0';
        set_x2 <= '0';
        set_x3 <= '0';
        set_x4 <= '0';
        rst_diff_reg <= '0';
        case sel is
            when "000" =>
                rst_diff_reg <= '1';
            when "001" =>
                set_x0 <= '1';
                
            when "010" =>
                set_x1 <= '1';
                
            when "011" =>
                set_x2 <= '1';
              
            when "100" =>
                set_x3 <= '1';
               
            when "101" =>
                set_x4 <= '1';
                
            when others =>
                 
        end case;

	end process;
	
	process(clk,x0,x1,x2,x3,x4,set_x0,set_x1,set_x2,set_x3,set_x4,rst) begin
	
	   if rst = '1' then
	    x0_diff_q <= (others => '0');
	    x1_diff_q <= (others => '0');
		x2_diff_q <= (others => '0');
		x3_diff_q <= (others => '0');
		x4_diff_q <= (others => '0');
		end if;
	   if rising_edge(clk) then
	   if set_x0 = '1' then
	       x0_diff_q <= x0 xor x0(18 downto 0)&x0(63 downto 19) xor x0(27 downto 0)&x0(63 downto 28) ;
	  -- end if;
	   
	   elsif set_x1 = '1' then
	       x1_diff_q <= x1 xor x1(60 downto 0)&x1(63 downto 61) xor x1(38 downto 0)&x1(63 downto 39) ;
	   --end if;
	   
	   elsif set_x2 = '1' then
	       x2_diff_q <= x2 xor x2(0)&x2(63 downto 1) xor x2(5 downto 0)&x2(63 downto 6) ;
	   --end if;
	   
	   elsif set_x3 = '1' then
	       x3_diff_q <= x3 xor x3(9 downto 0)&x3(63 downto 10) xor x3(16 downto 0)&x3(63 downto 17) ;
	   --end if;
	   
	   elsif set_x4 = '1' then
	       x4_diff_q <= x4 xor x4(6 downto 0)&x4(63 downto 7) xor x4(40 downto 0)&x4(63 downto 41) ;
	   
	   else
	       
--	    x0_diff_q <= (others => '0');
--	    x1_diff_q <= (others => '0');
--		x2_diff_q <= (others => '0');
--		x3_diff_q <= (others => '0');
--		x4_diff_q <= (others => '0');
	   end if;
	   end if;
	end process;

end Behavioral;
