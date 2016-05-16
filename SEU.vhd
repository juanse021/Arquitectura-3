--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU is
    Port ( imm : in  STD_LOGIC_VECTOR (12 downto 0);
           SEU_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU;

architecture Behavioral of SEU is
	
begin
	process(imm)
	begin
		
		SEU_out(12 downto 0) <= imm;
		if(imm(12) = '0')then
			SEU_out(31 downto 13) <= (others=>'0');
		else
			SEU_out(31 downto 13) <= (others=>'1');
		end if;			
	
	end process;
end Behavioral;