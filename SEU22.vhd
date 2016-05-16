--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU22 is
    Port ( imm22 : in  STD_LOGIC_VECTOR (21 downto 0);
           SEU22_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU22;

architecture Behavioral of SEU22 is

begin
	process(imm22)
	begin
		
		SEU22_out(21 downto 0) <= imm22;
		if(imm22(21) = '0')then
			SEU22_out(31 downto 22) <= (others=>'0');
		else
			SEU22_out(31 downto 22) <= (others=>'1');
		end if;			
	
	end process;
end Behavioral;

