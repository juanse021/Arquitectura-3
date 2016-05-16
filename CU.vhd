--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CU is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CU_out : out  STD_LOGIC_VECTOR (5 downto 0);
			  RFSOURCE : out STD_LOGIC_VECTOR (1 downto 0);
			  wrEnRF : out  STD_LOGIC;
			  wrEnMe : out  STD_LOGIC;
			  rfDest : out  STD_LOGIC);
end CU;

architecture Behavioral of CU is

begin

	process (Op, Op3)	
	begin
		
		if (op = "01") then
			wrEnRF <= '1';
			wrEnMe <= '0';
			rfDest <= '1'; 
			RFSOURCE <= "10";
			CU_out <= "000000"; 		
		else	
			rfDest <= '0';	
			RFSOURCE <= "01";
			if (op = "10") then
				wrEnRF <= '1';
				wrEnMe <= '0';
				case (Op3) is
					when("000000") =>			-- Add
						CU_out <= "000001"; 
					when("111100") =>			-- Save
						CU_out <= "000001"; 
					when("111101") =>			-- Restore
						CU_out <= "000001"; 
					when("000100") =>			-- Sub
						CU_out <= "000010"; 
					when("000001") =>			-- And
						CU_out <= "000011"; 
					when("000101") =>			-- Nand
						CU_out <= "000100"; 
					when("000010") =>			-- Or
						CU_out <= "000101"; 	
					when("000110") =>			-- Nor
						CU_out <= "000110"; 
					when("000011") =>			-- Xor
						CU_out <= "000111"; 
					when("000111") =>			-- Xnor
						CU_out <= "001000"; 	
					when("010000") =>			-- Addcc
						CU_out <= "001001"; 
					when("001000") =>			-- Addx
						CU_out <= "001010"; 
					when("011000") =>			-- Addxcc
						CU_out <= "001011"; 
					when("010100") =>			-- Subcc
						CU_out <= "001100"; 
					when("001100") =>			-- Subx
						CU_out <= "001101"; 
					when("011100") =>			-- Subxcc
						CU_out <= "001110"; 
					when("010001") =>			-- Andcc
						CU_out <= "001111"; 
					when("010101") =>			-- Nandcc
						CU_out <= "010000"; 
					when("010010") =>			-- Orcc
						CU_out <= "010001"; 
					when("010110") =>			-- Norcc
						CU_out <= "010010"; 
					when("010011") =>			-- Xorcc
						CU_out <= "010011"; 
					when("010111") =>			-- Xnorcc		
						CU_out <= "010100"; 		
					when others =>
						CU_out <= "000000";
						wrEnRF <= '0';
				end case;
			
			else
				if (op = "11") then		
					case (Op3) is
						when("000000") =>		-- Load
							wrEnRF <= '1'; 
							wrEnMe <= '0';
							RFSOURCE <= "00";
							CU_out <= "000001";
						when("000100") =>		-- Store
							wrEnRF <= '0';
							wrEnMe <= '1';	
							RFSOURCE <= "01";
							CU_out <= "000001";							
						when others =>
							wrEnRF <= '0'; 
							wrEnMe <= '0';
							RFSOURCE <= "01";
							CU_out <= "000000";
					end case;
				end if;			
			end if;
		end if;
	end process;

end Behavioral;