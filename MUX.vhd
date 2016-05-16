--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( entrada1 : in  STD_LOGIC_VECTOR (31 downto 0);
           entrada2 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUX_out : out  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC);
end MUX;

architecture Behavioral of MUX is

begin
	
	process (entrada1, entrada2, i)
	begin
	
		if (i = '0') then
			MUX_out <= entrada1;
		else
			MUX_out <= entrada2;
		end if;
	
	end process;
end Behavioral;