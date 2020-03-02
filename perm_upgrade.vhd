----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/04/2020 10:54:32 AM
-- Design Name: 
-- Module Name: perm - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.type_pkg.ALL;
use work.reg_array.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity perm is
--  Port ( );
	port (
		clk	: in std_logic;
		rst	: in std_logic;
		in0, in1, in2, in3, in4  : in  std_logic_vector(63 downto 0);
		out0, out1, out2, out3, out4 : out std_logic_vector(63 downto 0);
		rcin	: in std_logic_vector(3 downto 0);
		done	: out std_logic;
		perm_start : in std_logic
	);
end perm;

architecture Behavioral of perm is
type state_type is (s_reset, init, init2, load_input_array, load_output_array, load_diff_layer, final);
signal state, next_state : state_type:= s_reset;
type Row_Col is array (0 to 63) of x_reg;
signal sbox_out_array_reg, array_reg : Row_Col;
signal mux_out, demux_in: x_reg; 
signal local_sbox_count: std_logic_vector(5 downto 0);
signal inc_sbox_count, rst_sbox_count: std_logic;
signal sbox_array_count: std_logic_vector(5 downto 0):= "000000";
signal inc_array_count,rst_array_count,set_local_rc_count, set_round_constant: std_logic;
signal inc_diff_count,rst_diff_count, dec_local_rc_count: std_logic; 
signal input_array_int: integer;

signal set_done, rst_done, set_mux_sel, rst_mux_sel, set_input_mux_sel, rst_input_mux_sel : std_logic;

signal rst_input_array_int, inc_input_array_int, rst_diff_reg: std_logic;
signal en_input_0, en_input_1,en_input_2, en_input_3,en_input_4: std_logic;
signal output_reg_out_0,output_reg_out_1,output_reg_out_2,output_reg_out_3,output_reg_out_4: std_logic_vector(63 downto 0) := (others => '0');
signal en_output_0, en_output_1,en_output_2, en_output_3,en_output_4: std_logic;
signal reg_0_out,reg_1_out,reg_2_out,reg_3_out,reg_4_out: std_logic_vector(63 downto 0) := (others => '0');
signal round_constant, local_rc_count: std_logic_vector(3 downto 0):= x"0" ;
signal cr: std_logic_vector(63 downto 0);
signal in0_mux_out,in1_mux_out,in2_mux_out,in3_mux_out,in4_mux_out: std_logic_vector(63 downto 0);
signal mux_sel: std_logic_vector(5 downto 0):= "000000";
signal diff_sel: std_logic_vector(2 downto 0);
signal rst_diff_sel, inc_diff_sel, input_mux_sel: std_logic;
signal perm_start_reg, diff_start, diff0, diff1, diff2, diff3, diff4: std_logic;
signal x0_diff_in, x1_diff_in, x2_diff_in, x3_diff_in, x4_diff_in, x0_diff, x1_diff, x2_diff, x3_diff, x4_diff: std_logic_vector(63 downto 0) := (others => '0');
signal in_array_reg, in_sbox_out_array_reg_op, in_array_reg_op, out_array_reg, en_out_array_reg, en_in_array_reg : t_Row_Col; 
begin
    
    
	out0 <= output_reg_out_0;
	out1 <= output_reg_out_1;
	out2 <= output_reg_out_2;
	out3 <= output_reg_out_3;
	out4 <= output_reg_out_4;
    
    input_reg_0:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_input_0,
        din => in0,
        dout => reg_0_out
    );
     
    input_reg_1:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_input_1,
        din => in1,
        dout => reg_1_out
    );
        
    input_reg_2:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_input_2,
        din => in2,
        dout => reg_2_out
    );
        
    input_reg_3:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_input_3,
        din => in3,
        dout => reg_3_out
    );
        
    input_reg_4:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_input_4,
        din => in4,
        dout => reg_4_out
    );       
    
    input_mux_0:
    entity work.mux2to1(Behavioral)
    port map(
         sel => input_mux_sel, 
         in1 => reg_0_out,
         in2 => x0_diff,
         output => in0_mux_out
    );
    
    input_mux_1:
    entity work.mux2to1(Behavioral)
    port map(
         sel => input_mux_sel, 
         in1 => reg_1_out,
         in2 => x1_diff,
         output => in1_mux_out
    );    
        
    input_mux_2:
    entity work.mux2to1(Behavioral)
    port map(
         sel => input_mux_sel, 
         in1 => reg_2_out,
         in2 => x2_diff,
         output => in2_mux_out
    );
    
    input_mux_3:
    entity work.mux2to1(Behavioral)
    port map(
         sel => input_mux_sel, 
         in1 => reg_3_out,
         in2 => x3_diff,
         output => in3_mux_out
    );    
    
    input_mux_4:
    entity work.mux2to1(Behavioral)
    port map(
         sel => input_mux_sel, 
         in1 => reg_4_out,
         in2 => x4_diff,
         output => in4_mux_out
    );    
   
    const_add_layer:
    entity work.const_add(Behavioral)
    port map(
        rcin => round_constant,
        rcin_local => local_rc_count,
        cr => cr 
    );
    
    process(in0_mux_out, in1_mux_out, in2_mux_out, in3_mux_out, in4_mux_out, cr) begin
        for i in 0 to 63 loop 
            in_array_reg(0, i) <= in0_mux_out(63 - i);
            in_array_reg(1, i) <= in1_mux_out(63 - i);
            in_array_reg(2, i) <= in2_mux_out(63 - i) xor cr(63 - i);
            in_array_reg(3, i) <= in3_mux_out(63 - i);
            in_array_reg(4, i) <= in4_mux_out(63 - i);
        end loop;
    end process;
    
    input_array_reg:
    entity work.array_of_reg(Behavioral)
    port map(
        clk => clk,
        enable => en_in_array_reg,
        input => in_array_reg,
        output => in_array_reg_op
        );  

     process(in_array_reg_op) begin
     for i in 0 to 4 loop
        for j in 0 to 63 loop 
            array_reg(j)(i) <= in_array_reg_op(i, j);
        end loop;
    end loop;
    end process;

    special_mux:
    entity work.mux_64_to_1(Behavioral)
    port map(
        in0 =>  array_reg(0),
        in1 =>  array_reg(1),
        in2 =>  array_reg(2),
        in3 =>  array_reg(3), 
        in4 =>  array_reg(4),
        in5 =>  array_reg(5),
        in6 =>  array_reg(6),
        in7 =>  array_reg(7), 
        in8 =>  array_reg(8),
        in9 =>  array_reg(9),
        in10 =>  array_reg(10),
        in11 =>  array_reg(11), 
        in12 =>  array_reg(12),
        in13 =>  array_reg(13),
        in14 =>  array_reg(14),
        in15 =>  array_reg(15),
        in16 =>  array_reg(16),
        in17 =>  array_reg(17),
        in18 =>  array_reg(18),
        in19 =>  array_reg(19), 
        in20 =>  array_reg(20),
        in21 =>  array_reg(21),
        in22 =>  array_reg(22),
        in23 =>  array_reg(23), 
        in24 =>  array_reg(24),
        in25 =>  array_reg(25),
        in26 =>  array_reg(26),
        in27 =>  array_reg(27), 
        in28 =>  array_reg(28),
        in29 =>  array_reg(29),
        in30 =>  array_reg(30),
        in31 =>  array_reg(31),
        in32=>  array_reg(32),
        in33 =>  array_reg(33),
        in34 =>  array_reg(34),
        in35 =>  array_reg(35), 
        in36 =>  array_reg(36),
        in37 =>  array_reg(37),
        in38 =>  array_reg(38),
        in39 =>  array_reg(39), 
        in40 =>  array_reg(40),
        in41 =>  array_reg(41),
        in42 =>  array_reg(42),
        in43 =>  array_reg(43), 
        in44 =>  array_reg(44),
        in45 =>  array_reg(45),
        in46 =>  array_reg(46),
        in47 =>  array_reg(47),
        in48 =>  array_reg(48),
        in49 =>  array_reg(49),
        in50 =>  array_reg(50),
        in51 =>  array_reg(51), 
        in52 =>  array_reg(52),
        in53 =>  array_reg(53),
        in54 =>  array_reg(54),
        in55 =>  array_reg(55), 
        in56 =>  array_reg(56),
        in57 =>  array_reg(57),
        in58 =>  array_reg(58),
        in59 =>  array_reg(59), 
        in60 =>  array_reg(60),
        in61 =>  array_reg(61),
        in62 =>  array_reg(62),
        in63 =>  array_reg(63),
        output =>   mux_out,
        sel => mux_sel
    );
 
    special_sbox:
    entity work.sbox(Behavioral)
    port map(
        input =>    mux_out,
        output =>   demux_in
    );
 
    special_demux:
    entity work.demux_1_to_64(Behavioral)
    port map(
        in0 =>  sbox_out_array_reg(0),
        in1 =>  sbox_out_array_reg(1),
        in2 =>  sbox_out_array_reg(2),
        in3 =>  sbox_out_array_reg(3), 
        in4 =>  sbox_out_array_reg(4),
        in5 =>  sbox_out_array_reg(5),
        in6 =>  sbox_out_array_reg(6),
        in7 =>  sbox_out_array_reg(7), 
        in8 =>  sbox_out_array_reg(8),
        in9 =>  sbox_out_array_reg(9),
        in10 =>  sbox_out_array_reg(10),
        in11 =>  sbox_out_array_reg(11), 
        in12 =>  sbox_out_array_reg(12),
        in13 =>  sbox_out_array_reg(13),
        in14 =>  sbox_out_array_reg(14),
        in15 =>  sbox_out_array_reg(15),
        in16 =>  sbox_out_array_reg(16),
        in17 =>  sbox_out_array_reg(17),
        in18 =>  sbox_out_array_reg(18),
        in19 =>  sbox_out_array_reg(19), 
        in20 =>  sbox_out_array_reg(20),
        in21 =>  sbox_out_array_reg(21),
        in22 =>  sbox_out_array_reg(22),
        in23 =>  sbox_out_array_reg(23), 
        in24 =>  sbox_out_array_reg(24),
        in25 =>  sbox_out_array_reg(25),
        in26 =>  sbox_out_array_reg(26),
        in27 =>  sbox_out_array_reg(27), 
        in28 =>  sbox_out_array_reg(28),
        in29 =>  sbox_out_array_reg(29),
        in30 =>  sbox_out_array_reg(30),
        in31 =>  sbox_out_array_reg(31),
        in32 =>  sbox_out_array_reg(32),
        in33 =>  sbox_out_array_reg(33),
        in34 =>  sbox_out_array_reg(34),
        in35 =>  sbox_out_array_reg(35), 
        in36 =>  sbox_out_array_reg(36),
        in37 =>  sbox_out_array_reg(37),
        in38 =>  sbox_out_array_reg(38),
        in39 =>  sbox_out_array_reg(39), 
        in40 =>  sbox_out_array_reg(40),
        in41 =>  sbox_out_array_reg(41),
        in42 =>  sbox_out_array_reg(42),
        in43 =>  sbox_out_array_reg(43), 
        in44 =>  sbox_out_array_reg(44),
        in45 =>  sbox_out_array_reg(45),
        in46 =>  sbox_out_array_reg(46),
        in47 =>  sbox_out_array_reg(47),
        in48 =>  sbox_out_array_reg(48),
        in49 =>  sbox_out_array_reg(49),
        in50 =>  sbox_out_array_reg(50),
        in51 =>  sbox_out_array_reg(51), 
        in52 =>  sbox_out_array_reg(52),
        in53 =>  sbox_out_array_reg(53),
        in54 =>  sbox_out_array_reg(54),
        in55 =>  sbox_out_array_reg(55), 
        in56 =>  sbox_out_array_reg(56),
        in57 =>  sbox_out_array_reg(57),
        in58 =>  sbox_out_array_reg(58),
        in59 =>  sbox_out_array_reg(59), 
        in60 =>  sbox_out_array_reg(60),
        in61 =>  sbox_out_array_reg(61),
        in62 =>  sbox_out_array_reg(62),
        in63 =>  sbox_out_array_reg(63),
        input =>   demux_in,
        sel => mux_sel
    );   
    
     process(sbox_out_array_reg) begin
     for i in 0 to 4 loop
        for j in 0 to 63 loop 
            in_sbox_out_array_reg_op(i, j) <= sbox_out_array_reg(j)(i);
        end loop;
    end loop;
    end process;
      
    output_array_reg:
    entity work.array_of_reg(Behavioral)
    port map(
        clk => clk,
        enable => en_out_array_reg,
        output => out_array_reg,
        input =>  in_sbox_out_array_reg_op
    );  

    process (out_array_reg) begin 
        for i in 0 to 63 loop
            x0_diff_in(i) <= out_array_reg(0,63-i);
            x1_diff_in(i) <= out_array_reg(1,63-i);
            x2_diff_in(i) <= out_array_reg(2,63-i);
            x3_diff_in(i) <= out_array_reg(3,63-i);
            x4_diff_in(i) <= out_array_reg(4,63-i);
        end loop;
    end process;
    
    diffusion:
    entity work.diffusion_layer(Behavioral)
    port map(
        rst => rst,
        clk => clk,
        sel => diff_sel,
        x0 => x0_diff_in,
        x1 => x1_diff_in,
        x2 => x2_diff_in,
        x3 => x3_diff_in,
        x4 => x4_diff_in,
        x0_diff => x0_diff,
        x1_diff => x1_diff,
        x2_diff => x2_diff,
        x3_diff => x3_diff,
        x4_diff => x4_diff
    );
  
   
    output_reg_0:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_output_0,
        din => x0_diff,
        dout => output_reg_out_0
    );
       
    output_reg_1:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_output_1,
        din => x1_diff,
        dout => output_reg_out_1
    );
       
    output_reg_2:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_output_2,
        din => x2_diff,
        dout => output_reg_out_2
    );
       
    output_reg_3:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_output_3,
        din => x3_diff,
        dout => output_reg_out_3
    );
       
    output_reg_4:
    entity work.RegN(RegN)
    generic map (N => 64)
    port map(
        clk => clk,
        ena => en_output_4,
        din => x4_diff,
        dout => output_reg_out_4
    );    
    
    controller: process(state, perm_start,input_array_int,diff_sel,local_rc_count, sbox_array_count) begin
        next_state <= s_reset;
        inc_array_count <= '0';
        rst_array_count <= '0';
        inc_diff_count <= '0';
        rst_diff_count <= '0';
        inc_sbox_count <= '0';
        rst_sbox_count <= '0';
        rst_diff_sel <= '0';
        inc_diff_sel <= '0';
        set_round_constant <= '0';
        inc_input_array_int <= '0';
        rst_input_array_int <= '0';
        dec_local_rc_count <= '0';
        set_local_rc_count <= '0';
        rst_diff_reg <= '0';
        en_input_0 <= '0';
        en_input_1 <= '0';
        en_input_2 <= '0';
        en_input_3 <= '0';
        en_input_4 <= '0';
        en_output_0 <= '0';
        en_output_1 <= '0';
        en_output_2 <= '0';
        en_output_3 <= '0';
        en_output_4 <= '0';
        rst_mux_sel <= '0';
        for i in 0 to 4 loop
            for j in 0 to 63 loop
                en_in_array_reg(i,j) <= '0';
                en_out_array_reg(i,j) <= '0';
             end loop;
        end loop;
        
        set_done <= '0';
        rst_done <= '0';
        set_mux_sel <= '0';
        
        set_input_mux_sel <= '0';
        rst_input_mux_sel <= '0';
        
        case state is
        
            when s_reset =>
                rst_array_count <= '1';
                rst_diff_count <= '1';
                rst_sbox_count <= '1';
                rst_input_array_int <= '1';
                rst_diff_sel <= '1';
                rst_diff_reg <= '1';
	           	en_output_0 <= '1';
		        en_output_1 <= '1';
		        en_output_2 <= '1';
		        en_output_3 <= '1';
		        en_output_4 <= '1';
                next_state <= init;
            
            when init =>
                if perm_start = '1' then
                    set_local_rc_count <= '1';
                    set_round_constant <= '1';
                    rst_input_mux_sel <= '1';
                    next_state <= init2;
                else
                    next_state <= init;
                end if;
                
            when init2 =>
                en_input_0 <= '1';
                en_input_1 <= '1';
                en_input_2 <= '1';
                en_input_3 <= '1';
                en_input_4 <= '1';
                next_state <= load_input_array;
                
            when load_input_array =>
                en_in_array_reg(0,input_array_int) <= '1';
                en_in_array_reg(1,input_array_int) <= '1';
                en_in_array_reg(2,input_array_int) <= '1';
                en_in_array_reg(3,input_array_int) <= '1';
                en_in_array_reg(4,input_array_int) <= '1';
                if input_array_int = 63 then
                    next_state <= load_output_array;
                    rst_mux_sel <= '1';
                    rst_input_array_int <= '1';
                else
                    next_state <= load_input_array;
                    inc_input_array_int <= '1';
                end if;
                
            when load_output_array =>
                en_out_array_reg(0,input_array_int) <= '1';
                en_out_array_reg(1,input_array_int) <= '1';
                en_out_array_reg(2,input_array_int) <= '1';
                en_out_array_reg(3,input_array_int) <= '1';
                en_out_array_reg(4,input_array_int) <= '1';
              --  mux_sel <= sbox_array_count;
                set_mux_sel <= '1';
                if input_array_int = 63 then
                   -- set_mux_sel <= '0';
                    next_state <= load_diff_layer;
                    set_input_mux_sel <= '1';
                    rst_input_array_int <= '1';
                    rst_array_count <= '1';
                    rst_sbox_count <= '1';
                else
                    next_state <= load_output_array;
                    inc_input_array_int <= '1';
                    inc_array_count <= '1';
                    inc_sbox_count <= '1';
                end if;
                
            when load_diff_layer =>
                if diff_sel = "101" then
                    rst_diff_sel <= '1';
                    if local_rc_count = "001" then
                        rst_input_mux_sel <= '1';
                        set_done <= '1';
                        next_state <= final;
                    else
                        dec_local_rc_count <= '1';
                        set_input_mux_sel <= '1';
                        next_state <= load_input_array;
                    end if;
                else
                    inc_diff_sel <= '1';
                    next_state <= load_diff_layer;
                end if;    
                
            when final =>
                en_output_0 <= '1';
                en_output_1 <= '1';
                en_output_2 <= '1';
                en_output_3 <= '1';
                en_output_4 <= '1';
                rst_done <= '1';
                next_state <= init;
                   
        end case;
    end process;
 
    sync: process(rst, clk) begin
    if rst = '1' then
		state <= s_reset;
	else
		if rising_edge(clk) then
		  
		  if rst_mux_sel = '1' then 
		      mux_sel <= "000000";
		  end if; 
		 
		  if set_mux_sel = '1' then 
		      mux_sel <= sbox_array_count+ "000001";
		  end if;
		  
		  if set_done = '1' then
		      done <= '1';
		  end if;
		  
		  if rst_done = '1' then
		      done <= '0';
		  end if;
		  
		  if set_input_mux_sel = '1' then
		      input_mux_sel <= '1';
		  end if;
		  
		  if rst_input_mux_sel = '1' then
		      input_mux_sel <= '0';
		  end if;
		  
		  
		  if inc_array_count = '1' then
		      input_array_int <= input_array_int + 1;
		  end if;
		  
		  if set_local_rc_count = '1' then
		      local_rc_count <=rcin;
		  end if;
		  
		  if set_round_constant = '1' then
		      round_constant <= rcin;
		  end if;
		  
		  if rst_array_count = '1' then
		      input_array_int <= 0;
		  end if;
		  
--		  if inc_diff_count = '1' then
--		      diff_count <= diff_count + "000001";
--		  end if;
		  
--		  if rst_diff_count = '1' then
--		      diff_count <= "000000";
--		  end if;
		   
		  if inc_sbox_count = '1' then
		      sbox_array_count <= sbox_array_count + "000001";
		  end if;
		  
		  if rst_sbox_count = '1' then
		      sbox_array_count <= "000000";
		  end if;
		    
		  if inc_diff_sel = '1' then
		      diff_sel <= diff_sel + "001";		      
		  end if;
		  
		  if rst_diff_sel = '1' then
		      diff_sel <= "000";
		  end if;		
		
		  if inc_input_array_int = '1' then
		      input_array_int <= input_array_int + 1;
		  end if;
		  
		  if rst_input_array_int = '1' then
		      input_array_int <=  0;
		  end if;
		  
		  if dec_local_rc_count = '1' then
		      local_rc_count <= local_rc_count - x"1";		      
		  end if;
		  
		  state <= next_state;
		end if;  
	end if;	 
    end process; 
 
end Behavioral;
