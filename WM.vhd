--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WM is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : in  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC;
			  registroO7 : out STD_LOGIC_VECTOR(5 downto 0));
end WM;

architecture Behavioral of WM is

begin	
	
	process(rs1,rs2,rd,cwp,op,op3)
	begin
		
		if cwp = '1' then
			registroO7 <= "011111";
		else
			registroO7 <= "001111";
		end if;
	
		if(op = "10" and op3 = "111100")then--SAVE
			ncwp <= '0';
		elsif(op = "10" and op3 = "111101")then--RESTORE
			ncwp <= '1';
		end if;
		
		if(rs1>="00000" and rs1<="00111") then
			nrs1 <= '0'&rs1;
		elsif(rs1>="01000" and rs1<="01111") then	
			if cwp = '1' then
				nrs1 <= '0'&rs1 + "010000";
			else
				nrs1 <= '0'&rs1;
			end if;		
		elsif(rs1>="10000" and rs1<="10111") then
			if cwp = '1' then
				nrs1 <= '0'&rs1 + "010000";
			else
				nrs1 <= '0'&rs1;
			end if;
		elsif(rs1>="11000" and rs1<="11111") then
			if cwp = '1' then
				nrs1 <= '0'&rs1 - "010000";
			else
				nrs1 <= '0'&rs1;
			end if;
		end if;

		if(rs2>="00000" and rs2<="00111") then
			nrs2 <= '0'&rs2;
		elsif(rs2>="01000" and rs2<="01111") then	
			if cwp = '1' then
				nrs2 <= '0'&rs2 + "010000";
			else
				nrs2 <= '0'&rs2;
			end if;		
		elsif(rs2>="10000" and rs2<="10111") then
			if cwp = '1' then
				nrs2 <= '0'&rs2 + "010000";
			else
				nrs2 <= '0'&rs2;
			end if;
		elsif(rs2>="11000" and rs2<="11111") then
			if cwp = '1' then
				nrs2 <= '0'&rs2 - "010000";
			else
				nrs2 <= '0'&rs2;
			end if;
		end if;

	if(rd>="00000" and rd<="00111") then
			nrd <= '0'&rd;
		elsif(rd>="01000" and rd<="01111") then	
			if ((op3 = "111101") or ((cwp = '1') and (op3 /= "111100"))) then
				nrd <= '0'&rd + "010000";
			else
				nrd <= '0'&rd;
			end if;		
		elsif(rd>="10000" and rd<="10111") then
			if ((op3 = "111101") or ((cwp = '1') and (op3 /= "111100"))) then
				nrd <= '0'&rd + "010000";
			else
				nrd <= '0'&rd;
			end if;
		elsif(rd>="11000" and rd<="11111") then
			if ((op3 = "111101") or ((cwp = '1') and (op3 /= "111100"))) then
				nrd <= '0'&rd - "010000";
			else
				nrd <= '0'&rd;
			end if;
		end if;
	end process;
end Behavioral;