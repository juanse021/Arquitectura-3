--------------------------------------------------------------------------------
--                       Maria Alejandra Gomez Montoya                        --
--                       Juan Sebastian Herrera Giraldo                       --
--                       Cristhian Andrés Rivera Osorio                       --
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUXPC is
    Port ( entrada1 : in  STD_LOGIC_VECTOR (31 downto 0);
           entrada2 : in  STD_LOGIC_VECTOR (31 downto 0);
           entrada3 : in  STD_LOGIC_VECTOR (31 downto 0);
           entrada4 : in  STD_LOGIC_VECTOR (31 downto 0);
           MUXPC_out : out  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC_VECTOR (1 downto 0));
end MUXPC;

architecture Behavioral of MUXPC is

begin

	process (entrada1, entrada2, entrada3, entrada4, i)
	begin
	
		if (i = "00") then
			MUXPC_out <= entrada1;
		elsif (i = "01") then 
			MUXPC_out <= entrada2;
		elsif (i = "10") then 
			MUXPC_out <= entrada3;
		elsif (i = "11") then 
			MUXPC_out <= entrada4;
		end if;
	
	end process;
	
end Behavioral;

