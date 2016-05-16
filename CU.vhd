--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
           
entity CU is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  Op2 : in  STD_LOGIC_VECTOR (2 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  cond : in  STD_LOGIC_VECTOR (3 downto 0);
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  a : in  STD_LOGIC;
			  a_out : out  STD_LOGIC;
           CU_out : out  STD_LOGIC_VECTOR (5 downto 0);
			  RFSOURCE : out STD_LOGIC_VECTOR (1 downto 0);
			  PCSOURCE : out STD_LOGIC_VECTOR (1 downto 0);
			  wrEnRF : out  STD_LOGIC;
			  wrEnMe : out  STD_LOGIC;
			  rfDest : out  STD_LOGIC);
end CU;

architecture Behavioral of CU is

begin 

	process (Op, Op2, Op3, cond, icc, a)	
	begin
		
		if (Op = "01") then			-- Call
			wrEnRF <= '1';
			wrEnMe <= '0';
			rfDest <= '1'; 
			RFSOURCE <= "10";
			PCSOURCE <= "00";
			CU_out <= "000000"; 
			a_out <= '0';
			 
		else	
			rfDest <= '0';
			if(Op = "00")then
				wrEnRF <= '0';
				wrEnMe <= '0';				
				RFSOURCE <= "01";
				CU_out <= "000000";
				if(Op2 = "010")then
					case cond is
						when "1000" => 				-- Branch Always
							PCSOURCE <= "01";	
							if a = '1' then
								a_out <= '1';
							else
								a_out <= '0';
							end if;
						when "0000" =>					-- Branch Never
							PCSOURCE <= "10";
							a_out <= '0';
						when "1001" => 				-- Branch on Not Equal
							if(not(icc(2)) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "0001" => 				-- Branch on Equal
							if(icc(2) = '1') then 
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1010" => 				-- Branch on Greater
							if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then 
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;						when "0010" => 				-- Branch on Less or Equal
							if((icc(2) or (icc(3) xor icc(1))) = '1') then 
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1011" => 				-- Branch on Greater or Equal
							if((not(icc(3) xor icc(1))) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "0011" => 				-- Branch on Less
							if((icc(3) xor icc(1)) = '1') then 
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1100" =>					-- Branch on Greater Unsigned
							if((not(icc(0) or icc(2))) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;					
						when "0100" =>					-- Branch on Less or Equal Unsigned
							if((icc(0) or icc(2)) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1101" => 				-- Branch on Carry Clear (Greater than or Equal, Unsigned)
							if ((not(icc(0))) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "0101" =>					-- Branch on Carry Set (Less than, Unsigned)
							if ((icc(0)) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1110" =>					-- Branch on Positive
							if ((not(icc(3))) = '1') then 
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "0110" =>					-- Branch on Negative
							if ((icc(3)) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "1111" =>					-- Branch on Overflow Clear
							if ((not(icc(1))) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when "0111" =>					-- Branch on Overflow Set
							if ((icc(1)) = '1') then
								PCSOURCE <= "01";	
								if a = '1' then
									a_out <= '1';
								else
									a_out <= '0';
								end if;
							else
								PCSOURCE <= "10";	
								a_out <= '0';
							end if;
						when others => 
							PCSOURCE <= "10";	
							a_out <= '0';
					end case;
				elsif(Op2 = "100")then	-- Nop
					PCSOURCE <= "10";
					a_out <= '0';
				end if;
				
			else	
				a_out <= '0';
				if (Op = "10") then	
					wrEnMe <= '0';
					case (Op3) is
						when("000000") =>			-- Add	
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000001"; 
							wrEnRF <= '1';
						when("111100") =>			-- Save
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000001"; 
							wrEnRF <= '1';
						when("111101") =>			-- Restore
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000001"; 
							wrEnRF <= '1';
						when("111000") =>			--JMPL
							RFSOURCE <= "10";
							PCSOURCE <= "11";	
							CU_out <= "000001";
							wrEnRF <= '1';												
						when("000100") =>			-- Sub
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000010"; 
							wrEnRF <= '1';
						when("000001") =>			-- And
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000011";
							wrEnRF <= '1';						
						when("000101") =>			-- Nand
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000100"; 
							wrEnRF <= '1';
						when("000010") =>			-- Or
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000101"; 
							wrEnRF <= '1';						
						when("000110") =>			-- Nor
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000110"; 
							wrEnRF <= '1';
						when("000011") =>			-- Xor
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000111"; 
							wrEnRF <= '1';
						when("000111") =>			-- Xnor
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001000"; 
							wrEnRF <= '1';						
						when("010000") =>			-- Addcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001001"; 
							wrEnRF <= '1';
						when("001000") =>			-- Addx
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001010"; 
							wrEnRF <= '1';
						when("011000") =>			-- Addxcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001011"; 
							wrEnRF <= '1';
						when("010100") =>			-- Subcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001100"; 
							wrEnRF <= '1';
						when("001100") =>			-- Subx
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001101";
							wrEnRF <= '1';						
						when("011100") =>			-- Subxcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001110"; 
							wrEnRF <= '1';
						when("010001") =>			-- Andcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "001111"; 
							wrEnRF <= '1';
						when("010101") =>			-- Nandcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "010000"; 
							wrEnRF <= '1';
						when("010010") =>			-- Orcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "010001"; 
							wrEnRF <= '1';
						when("010110") =>			-- Norcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "010010"; 
							wrEnRF <= '1';
						when("010011") =>			-- Xorcc
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "010011"; 
							wrEnRF <= '1';
						when("010111") =>			-- Xnorcc	
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "010100";
							wrEnRF <= '1';							
						when others =>
							RFSOURCE <= "01";
							PCSOURCE <= "10";	
							CU_out <= "000000";
							wrEnRF <= '0';
					end case;
				
				else
					CU_out <= "000001";
					PCSOURCE <= "10";
					RFSOURCE <= "00";
					if (Op = "11") then		
						case (Op3) is
							when("000000") =>		-- Load
								wrEnRF <= '1'; 
								wrEnMe <= '0';								
							when("000100") =>		-- Store
								wrEnRF <= '0';
								wrEnMe <= '1';						
							when others =>
								wrEnRF <= '0'; 
								wrEnMe <= '0';
						end case;
					end if;			
				end if;
			end if;
		end if;
	end process;

end Behavioral;